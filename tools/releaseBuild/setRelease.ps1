param(
    [Parameter(HelpMessage='The branch name used to update the release tag.')]
    [string]$Branch=$env:BUILD_SOURCEBRANCH,

    [Parameter(HelpMessage='The variable name to put the new release tagin.')]
    [string]$Variable='ReleaseTag'
)

# Script to set the release tag based on the branch name if it is not set or it is "fromBranch"
# the branch name is expected to be release-<semver> or <previewname>
# VSTS passes it as 'refs/heads/release-v6.0.2'

$branchOnly = $Branch -replace '^refs/heads/';
$branchOnly = $branchOnly -replace '[_\-]'

if($branchOnly -eq 'master' -or $branchOnly -like '*dailytest*')
{
    Write-verbose "release branch:" -verbose
    $releaseTag = 'edge'
    $vstsCommandString = "vso[task.setvariable variable=$Variable]$releaseTag"
    Write-Verbose -Message "setting $Variable to $releaseTag" -Verbose
    Write-Host -Object "##$vstsCommandString"
}
else
{
    Write-verbose "non-release branch" -verbose
    # Branch is named <previewname>

    $releaseTag = "hotfix/$branchOnly"
    $vstsCommandString = "vso[task.setvariable variable=$Variable]$releaseTag"
    Write-Verbose -Message "setting $Variable to $releaseTag" -Verbose
    Write-Host -Object "##$vstsCommandString"
}

Write-Output $releaseTag
