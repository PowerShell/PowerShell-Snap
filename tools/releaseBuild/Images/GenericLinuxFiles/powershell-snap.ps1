# PowerShell Script to build and package PowerShell from specified form and branch
# Script is intented to use in Docker containers
# Ensure PowerShell is available in the provided image

param (
    [string] $location = "/powershell",

    # Destination location of the package on docker host
    [string] $destination = '/mnt',

    [ValidatePattern("^v\d+\.\d+\.\d+(-\w+(\.\d+)?)?$")]
    [ValidateNotNullOrEmpty()]
    [string]$ReleaseTag
)

$ErrorActionPreference = 'Stop'
$releaseTagParam = @{}
if ($ReleaseTag)
{
    $releaseTagParam = @{ 'ReleaseTag' = $ReleaseTag }
}

Push-Location
try {
    Set-Location $location
    if($ReleaseTag)
    {
        $version = $ReleaseTag -Replace '^v'
        $version | out-file -filePath './version.txt' -encoding ascii
        Write-Verbose "verify version..." -Verbose
        cat ./version.txt
    }
    Write-Verbose "building prime..." -Verbose
    snapcraft prime
    # workaround for https://bugs.launchpad.net/snapcraft/+bug/1746329
    patchelf --force-rpath --set-rpath '/snap/core/current/usr/lib/x86_64-linux-gnu:/snap/core/current/lib/x86_64-linux-gnu:/snap/powershell/current/usr/lib/x86_64-linux-gnu' ./prime/opt/powershell/pwsh
    Write-Verbose "verify rpath..." -Verbose
    patchelf --print-rpath ./prime/opt/powershell/pwsh
    Write-Verbose "packing..." -Verbose
    snapcraft pack prime
}
finally
{
    Pop-Location
}

$linuxPackages = Get-ChildItem "$location/powershell*" -Include *.snap
foreach ($linuxPackage in $linuxPackages)
{
    $filePath = $linuxPackage.FullName
    Write-Verbose "Copying $filePath to $destination" -Verbose
    Copy-Item -Path $filePath -Destination $destination -force
}
