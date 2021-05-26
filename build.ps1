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
    $Choco
)

process {

    $root = Split-Path -Parent $MyInvocation.MyCommand.Definition

    switch ($true) {

        $Build {

            if (Test-Path "$root\Output") {
                Remove-Item "$root\Output\TreasureChest\*.psm1" -Recurse -Force
            } else {
                $Null = New-Item "$root\Output" -ItemType Directory
                $null = New-item "$root\Output\TreasureChest" -ItemType Directory
            }
        
            if (Test-Path "$root\src\nuget\tools\TreasureChest.zip") {
                Remove-Item "$root\src\nuget\tools\TreasureChest.zip" -Force
            }
            
            Get-ChildItem $root\src\public\*.ps1 | 
            Foreach-Object { 
                Get-Content $_.FullName | Add-Content "$root\Output\TreasureChest\TreasureChest.psm1" -Force
            }

            Get-ChildItem $root\src\private\*.ps1 | 
            Foreach-Object { 
                Get-Content $_.FullName | Add-Content "$root\Output\TreasureChest\TreasureChest.psm1" -Force
            }

            Copy-Item $root\TreasureChest.psd1 $root\Output\TreasureChest -Force


        }

        $TestPrePublish {
            
            Get-ChildItem $root\src\public\*.ps1, $root\Poshbot\*.ps1 | 
            Foreach-Object { 
                . $_.FullName
            }
            #Import-Module "$root\Output\TreasureChest\TreasureChest.psd1" -Force
            Import-Module PoshBot -Force

            Invoke-Pester "$root\tests\pre"
            
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
            
            $Nuspec = Get-ChildItem "$root\src\nuget" -recurse -filter *.nuspec

            if (Test-Path "$root\src\nuget\tools\TreasureChest.zip") {
                choco pack $Nuspec.Fullname --output-directory $Nuspec.directory
            }

            else {
                throw "Welp, ya need the zip in the tools folder, dumby"
            }
            Get-ChildItem "$root\src\nuget" -recurse -filter *.nupkg | 
            Foreach-Object { 
                choco push $_.FullName -s https://push.chocolatey.org --api-key="'$($env:ChocoApiKey)'"
            }

        }

    }

}