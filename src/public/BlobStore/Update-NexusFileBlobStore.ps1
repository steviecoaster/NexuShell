function Update-NexusFileBlobStore {
    <#
    .SYNOPSIS
    Updates some properties of a given file blobstore

    .PARAMETER Name
    The Name of the file blobstore to update

    .PARAMETER Path
    The path for the blob store to use

    .PARAMETER SoftQuotaType
    The type of soft quota limit to enforce

    .PARAMETER SoftQuotaLimit
    The size of the soft quota limit, in MB

    .NOTES
    This does not automatically migrate blobs from the previous location.
    There may be some time where the store is inaccessible.

    .EXAMPLE
    Update-NexusFileBlobStore -Name default -Path D:\NexusStore

    # Sets the default blobstore to the location listed
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/Update-NexusFileBlobStore/', SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory)]
        [string]
        $Name,

        [string]
        $Path,

        [ValidateSet("Remaining", "Used")]
        [string]
        $SoftQuotaType,

        [ValidateRange(1, [int]::MaxValue)]
        [int]
        $SoftQuotaLimit
    )
    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }
    end {
        $urislug = "/service/rest/v1/blobstores/file/$Name"

        $Body = Get-NexusBlobStore -Name $Name -Type File | Convert-ObjectToHashtable

        $Modified = $false
        switch -Wildcard ($PSBoundParameters.Keys) {
            "Path" {
                if ($Body.path -ne $Path) {
                    $Body.path = $Path
                    $Modified = $true
                }
            }
            "SoftQuota*" {
                if (-not $Body.softQuota) {
                    $Body.softQuota = @{}
                }
            }
            "SoftQuotaType" {
                if ($Body.softQuota.type -ne "space$($SoftQuotaType)Quota") {
                    $Body.softQuota.type = "space$($SoftQuotaType)Quota"
                    $Modified = $true
                }
            }
            "SoftQuotaLimit" {
                if ($Body.softQuota.limit -ne $SoftQuotaLimit) {
                    $Body.softQuota.limit = $SoftQuotaLimit * 1MB
                    $Modified = $true
                }
            }
        }

        if ($Modified) {
            if ($PSCmdlet.ShouldProcess($Name, "Update File Blob Store")) {
                Invoke-Nexus -UriSlug $urislug -Method Put -Body $Body
            }
        } else {
            Write-Verbose "No change to '$($Name)' was required."
        }
    }
}