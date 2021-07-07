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
    [Switch]
    $Choco,

    [Parameter()]
    [string]
    $SemVer = $(
        if (Get-Command gitversion -ErrorAction SilentlyContinue) {
            (gitversion | ConvertFrom-Json).LegacySemVerPadded
        }
    )
)
process {
    $root = Split-Path -Parent $MyInvocation.MyCommand.Definition
    
    switch ($true) {
        $Build {
            Build-Module -SemVer $SemVer
        }

        $TestPrePublish {
            if (Test-Path $root\Output\TreasureChest) {
                if ($env:PSModulePath.Split(';') -notcontains "$root\Output") {
                    $env:PSModulePath = "$root\Output;$env:PSModulePath"
                }
                Import-Module TreasureChest
            }

            $TestArguments = @{
                Path                   = "$root\tests"

                OutputFile             = "$root\TestResults.xml"
                OutputFormat           = "JUnitXml"
                
                CodeCoverage           = (Get-ChildItem $root\Output\TreasureChest -Recurse -Filter '*.ps*1').FullName
                CodeCoverageOutputFile = "$root\Coverage.xml"
            }

            if (Test-Path $TestArguments.Path) {
                Invoke-Pester @TestArguments
            }
        }

        $TestPostPublish {
            Install-Module TreasureChest -Force
            Import-Module PoshBot -Force

            Invoke-Pester "$root\tests\*.ps1"
        }

        $DeployToGallery {
            Publish-Module -Path "$root\Output\TreasureChest" -NuGetApiKey $env:NugetApiKey
        }

        $Choco {
            $PackageSource = Join-Path $root "src\nuget"

            $Nuspec = Get-ChildItem $PackageSource -recurse -filter *.nuspec

            Copy-Item -Path $root\LICENSE -Destination $PackageSource

            if (Test-Path "$PackageSource\tools\TreasureChest.zip") {
                choco pack $Nuspec.FullName --output-directory $root
            } else {
                throw "Welp, ya need the zip in the tools folder, dumby"
            }

            Get-ChildItem $PackageSource -recurse -filter *.nupkg | ForEach-Object { 
                choco push $_.FullName -s https://push.chocolatey.org --api-key="'$($env:ChocoApiKey)'"
            }
        }
    }
}