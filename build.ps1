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
    $WriteMdDocs,

    [Parameter()]
    [Switch]
    $MkDocsPublish,

    [Parameter()]
    [Switch]
    $GHPages,

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

        $Choco {
            $PackageSource = Join-Path $root "src\nuget"

            $Nuspec = Get-ChildItem $PackageSource -recurse -filter *.nuspec

            Copy-Item -Path $root\LICENSE -Destination $PackageSource
            Compress-Archive -Path $root\Output\* -DestinationPath $PackageSource\tools\NexuShell.zip -Force #Added force to allow local testing without shenanigans

            if (Test-Path "$PackageSource\tools\NexuShell.zip") {
                choco pack $Nuspec.FullName --output-directory $root
            } else {
                throw "Welp, ya need the zip in the tools folder, dumby"
            }

            Get-ChildItem $PackageSource -recurse -filter *.nupkg | ForEach-Object { 
                choco push $_.FullName -s https://push.chocolatey.org --api-key="'$($env:ChocoApiKey)'"
            }
        }

        $WriteMdDocs {
            if (Test-Path $root\Output\NexuShell) {
                if ($env:PSModulePath.Split(';') -notcontains "$root\Output") {
                    $env:PSModulePath = "$root\Output;$env:PSModulePath"
                }
                Import-Module NexuShell -Force
                Import-Module PlatyPS -Force

                New-MarkdownHelp -Module NexuShell -OutputFolder $root\docs

            }
        }

        $MkDocsPublish {
            $mkDocsRoot = Join-Path $root 'mkdocs_template'
            Push-Location $mkDocsRoot
            $mkDocsArgs = @('build')

            & 'C:\Python39\Scripts\mkdocs.exe' @mkDocsArgs
        }

        $GHPages {
            # Write your PowerShell commands here.
            git config --global user.name 'Stephen Valdinger'
            git config --global user.email 'stephen@chocolatey.io'
            git remote rm origin
            $url = 'https://steviecoaster:' + $env:GH_TOKEN + '@github.com/steviecoaster/NexuShell.git'
            git remote add origin $url

            $mkDocsArgs = @('gh-deploy','--force')

            Set-Location .\mkdocs_template
            & 'C:\Python39\Scripts\mkdocs.exe' @mkDocsArgs
        }
    }
}