function Get-NexusBlobStoreQuota {
    [CmdletBinding()]
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