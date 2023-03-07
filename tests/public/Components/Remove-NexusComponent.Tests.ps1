#requires -Modules NexuShell

Describe "Remove-NexusComponent" {
    BeforeAll {
        $InModule = @{
            ModuleName = "NexuShell"
        }

        InModuleScope @InModule {
            $script:header = @{
                Authentication = "fake auth"
            }
        }

        Mock Invoke-Nexus @InModule
    }

    Context "Removing a component from Nexus" {
        BeforeAll {
            $TestId = (New-Guid).Guid
            $Result = Remove-NexusComponent -Id $TestId -Confirm:$false
        }

        It "Attempts to remove the correct component" {
            Assert-MockCalled Invoke-Nexus @InModule -ParameterFilter {
                $UriSlug -eq "/service/rest/v1/components/$TestId" -and
                $Method -eq "Delete"
            } -Scope Context
        }

        It "Returns nothing" {
            $Result | Should -BeNullOrEmpty
        }
    }

    Context "Removing multiple components from Nexus" {
        BeforeAll {
            $TestIds = (New-Guid).Guid, (New-Guid).Guid

            Mock Get-NexusComponent {
                [PSCustomObject]@{
                    Id         = $TestIds[0]
                    Repository = "dev"
                    Format     = "nuget"
                    Group      = $null
                    Name       = "somepackage"
                    Version    = "1.0"
                    Assets     = @{}
                }
                [PSCustomObject]@{
                    Id         = $TestIds[1]
                    Repository = "dev"
                    Format     = "nuget"
                    Group      = $null
                    Name       = "somepackage"
                    Version    = "1.1"
                    Assets     = @{}
                }
            }

            $Result = Remove-NexusComponent -Id $TestIds -Confirm:$false
        }

        It "Attempts to remove the correct components" {
            Assert-MockCalled Invoke-Nexus @InModule -ParameterFilter {
                $UriSlug -eq "/service/rest/v1/components/$($TestIds[0])" -and
                $Method -eq "Delete"
            } -Scope Context -Times 1

            Assert-MockCalled Invoke-Nexus @InModule -ParameterFilter {
                $UriSlug -eq "/service/rest/v1/components/$($TestIds[1])" -and
                $Method -eq "Delete"
            } -Scope Context -Times 1
        }

        It "Returns nothing" {
            $Result | Should -BeNullOrEmpty
        }
    }

    Context "Removing components from pipelined input" {
        BeforeAll {
            $TestIds = (New-Guid).Guid, (New-Guid).Guid

            Mock Get-NexusComponent {
                [PSCustomObject]@{
                    Id         = $TestIds[0]
                    Repository = "dev"
                    Format     = "nuget"
                    Group      = $null
                    Name       = "somepackage"
                    Version    = "1.0"
                    Assets     = @{}
                }
                [PSCustomObject]@{
                    Id         = $TestIds[1]
                    Repository = "dev"
                    Format     = "nuget"
                    Group      = $null
                    Name       = "somepackage"
                    Version    = "1.1"
                    Assets     = @{}
                }
            }

            $Result = Get-NexusComponent -Repository dev | Remove-NexusComponent -Confirm:$false
        }

        It "Attempts to remove both components" {
            Assert-MockCalled Invoke-Nexus @InModule -ParameterFilter {
                $UriSlug -eq "/service/rest/v1/components/$($TestIds[0])" -and
                $Method -eq "Delete"
            } -Scope Context -Times 1

            Assert-MockCalled Invoke-Nexus @InModule -ParameterFilter {
                $UriSlug -eq "/service/rest/v1/components/$($TestIds[1])" -and
                $Method -eq "Delete"
            } -Scope Context -Times 1
        }

        It "Returns nothing" {
            $Result | Should -BeNullOrEmpty
        }
    }

    Context "ShouldProcess Compatibility" {
        BeforeAll {
            $TestId = (New-Guid).Guid
            Remove-NexusComponent -Id $TestId -WhatIf
        }

        It "Does not attempt to remove the component when called with -WhatIf" {
            Assert-MockCalled Invoke-Nexus @InModule -ParameterFilter {
                $UriSlug -eq "/service/rest/v1/components/$TestId" -and
                $Method -eq "Delete"
            } -Scope Context -Times 0
        }
    }
}