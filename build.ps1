param(
    [ValidateSet('Docker','Official')]
    [string]$BuildType="Docker",
    [switch]$Preview
)

$directory = 'stable'
if($Preview.IsPresent)
{
    $directory='preview'
}

$fullDirectory = Join-Path -Path $psscriptroot -ChildPath $directory

Write-verbose -message "fd: $fullDirectory" -verbose

switch($BuildType)
{
    'Docker' {
        $command = "echo `$PWD && apt update && snapcraft --version && snapcraft clean -s build && snapcraft" 
        Write-verbose -message $command -verbose
        docker run -v ${fullDirectory}:${fullDirectory} -w ${fullDirectory} 'snapcore/snapcraft:stable' sh -c $command
    }
    'Official' {
        $name = 'powershell-snap-latest'
        if($Preview.IsPresent)
        {
            $name = 'powershell-snap-preview-latest'
        }

        &"$PSScriptRoot/tools/releaseBuild/vstsbuild.ps1" -Name $Name
    }
    default {
        throw "Unknown BuildType: $BuildType"
    }
}
