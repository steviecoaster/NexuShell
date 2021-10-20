#requires -Modules NexuShell

Describe "Update-NexusFileBlobStore" {
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
        Mock Get-NexusBlobStore @InModule -MockWith {
            if ($script:BlobStoreObject) {
                $script:BlobStoreObject
            } else {
                [PSCustomObject]@{
                    path = "default"
                    softQuota = @{
                        type  = ""
                        limit = ""
                    }
                }
            }
        }
    }

    Context "Updating a BlobStore Path from 'default'" {
        BeforeAll {
            Update-NexusFileBlobStore -Name "Test" -Path "D:\Repository\" -Confirm:$false
        }

        It "Sets the specified path for the specified BlobStore" {
            Assert-MockCalled Invoke-Nexus @InModule -ParameterFilter {
                $UriSlug -eq "/service/rest/v1/blobstores/file/Test" -and
                $Method -eq "Put" -and
                $Body.path -eq "D:\Repository\"
            } -Scope Context
        }
    }

    Context "Updating a BlobStore Path that is already correct" {
        BeforeAll {
            Update-NexusFileBlobStore -Name "Test" -Path "default" -Confirm:$false
        }

        It "Does not attempt to modify the BlobStore" {
            Assert-MockCalled Invoke-Nexus @InModule -Times 0 -Scope Context
        }
    }

    Context "Updating a BlobStore Quota" {
        BeforeAll {
            Update-NexusFileBlobStore -Name "QuotaTest" -SoftQuotaType Remaining -SoftQuotaLimit 203 -Confirm:$false
        }

        It "Sets the specified quota limit for the specified BlobStore" {
            Assert-MockCalled Invoke-Nexus @InModule -ParameterFilter {
                $UriSlug -eq "/service/rest/v1/blobstores/file/QuotaTest" -and
                $Method -eq "Put" -and
                $Body.softQuota.type -eq "spaceRemainingQuota" -and
                $Body.softQuota.limit -eq 203MB
            } -Scope Context
        }
    }
}