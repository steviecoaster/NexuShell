function Get-NexusBlobStoreQuota {
    <#
    .SYNOPSIS
    Get the quota settings of a blob store
    
    .DESCRIPTION
    Get the quota settings of a blob store
    
    .PARAMETER Name
    The blob store to retrieve quota settings
    
    .EXAMPLE
    Get-NexusBlobStoreQuota -Name TestBlob
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Get-NexusBlobStoreQuota/')]
    Param(
        [Parameter(Mandatory)]
        [String[]]
        $Name
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/blobstores"
    }
    process {

        $Name | Foreach-Object {

            $Uri = $urislug + "/$_/quota-status"
            Invoke-Nexus -UriSlug $Uri -Method 'GET'

        }
    }
}