[cmdletbinding(DefaultParameterSetName='default')]
# PowerShell Script to build and package PowerShell from specified form and branch
# Script is intented to use in Docker containers
# Ensure PowerShell is available in the provided image

param (
    [string] $location = "/powershell",

    # Destination location of the package on docker host
    [string] $destination = '/mnt',

    [ValidatePattern("^v\d+\.\d+\.\d+(-\w+(\.\d+)?)?$")]
    [ValidateNotNullOrEmpty()]
    [string]$ReleaseTag,

    [parameter(parametersetName='preview',Mandatory)]
    [switch]$Preview,

    [parameter(parametersetName='lts',Mandatory)]
    [switch]$LTS
)

$directory = 'stable'
if ($Preview.IsPresent) {
    $directory = 'preview'
}
elseif ($LTS.IsPresent) {
    $directory = 'lts'
}

$ErrorActionPreference = 'Stop'
$releaseTagParam = @{}
if ($ReleaseTag)
{
    $releaseTagParam = @{ 'ReleaseTag' = $ReleaseTag }
}

Push-Location
try {
    Write-Verbose "snapcraft version $(snapcraft --version)" -Verbose
    Set-Location (Join-Path -Path $location -ChildPath $directory)
    Write-Verbose -message "building $pwd" -Verbose
    if ($ReleaseTag) {
        $version = $ReleaseTag -Replace '^v'
        $version | out-file -filePath './version.txt' -encoding ascii
        Write-Verbose "verify version..." -Verbose
        cat ./version.txt
    }

    Write-Verbose "building snap..." -Verbose
    snapcraft snap
}
finally
{
    Pop-Location
}

$linuxPackages = Get-ChildItem "$location/powershell*.snap" -Recurse
foreach ($linuxPackage in $linuxPackages)
{
    $filePath = $linuxPackage.FullName
    Write-Verbose "Copying $filePath to $destination" -Verbose
    Copy-Item -Path $filePath -Destination $destination -force
}
