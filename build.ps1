param(
    [ValidateSet('Docker','Official')]
    [string]$BuildType="Docker"
)

switch($BuildType)
{
    'Docker' {
        docker run -v ${psscriptroot}:${psscriptroot} -w ${psscriptroot} 'snapcore/snapcraft:stable' sh -c 'apt update && snapcraft --version && snapcraft clean -s build && snapcraft' 
    }
    'Official' {
        &"$PSScriptRoot/tools/releaseBuild/vstsbuild.ps1" -Name powershell-snap-latest
    }
    default {
        throw "Unknown BuildType: $BuildType"
    }
}

