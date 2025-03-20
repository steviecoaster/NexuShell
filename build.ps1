[cmdletBinding()]
param(
    [Parameter()]
    [Switch]
    $Build,
    
    [Parameter()]
    [Switch]
    $TestPrePublish,

    [Parameter()]
    [Switch]
    $TestPostPublish,

    [Parameter()]
    [Switch]
    $DeployToGallery,

    [Parameter()]
    [string]
    $SemVer = $(
        if (Get-Command gitversion -ErrorAction SilentlyContinue) {
            if (([version]((gitversion /version).Split('+')[0])).Major -gt 5) {
                gitversion /showvariable SemVer
            } else {
                gitversion /showvariable LegacySemVerPadded
            }
        }
    )
)
process {
    $root = Split-Path -Parent $MyInvocation.MyCommand.Definition
    
    switch ($true) {
        (-not $env:CI) {
            . $PSScriptRoot\Requirements.ps1
        }

        $Build {
            Build-Module -SemVer $SemVer
        }

        $TestPrePublish {
            if (Test-Path $root\Output\NexuShell) {
                if ($env:PSModulePath.Split(';') -notcontains "$root\Output") {
                    $env:PSModulePath = "$root\Output;$env:PSModulePath"
                }
                Import-Module NexuShell
            }

            $TestConfiguration = New-PesterConfiguration @{
                Run          = @{
                    Path = "$root\tests"
                }
                TestResult   = @{
                    Enabled      = $true
                    OutputPath   = "$root\TestResults.xml"
                    OutputFormat = "JUnitXml"
                }
                Output = @{
                    Verbosity  = "Detailed"
                }
                CodeCoverage = @{
                    Enabled    = $true
                    Path       = (Get-ChildItem $root\Output\NexuShell -Recurse -Filter '*.ps*1').FullName
                    OutputPath = "$root\Coverage.xml"
                }
            }

            if (Test-Path $TestConfiguration.Run.Path.Value) {
                Invoke-Pester -Configuration $TestConfiguration
            }
        }

        $TestPostPublish {
            Install-Module NexuShell -Force
            Import-Module PoshBot -Force

            Invoke-Pester "$root\tests\*.ps1"
        }

        $DeployToGallery {
            Publish-Module -Path "$root\Output\NexuShell" -NuGetApiKey $env:NugetApiKey
        }
    }
}