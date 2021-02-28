function Remove-NexusBlobStore {
    <#
    .SYNOPSIS
    Deletes a Nexus blob store
    
    .DESCRIPTION
    Deletes a Nexus blob store
    
    .PARAMETER Name
    The blob store to remove
    
    .PARAMETER Force
    Disable confirmation of the delete action.
    
    .EXAMPLE
    Remove-NexusBlobStore -Name TreasureBlob

    .EXAMPLE
    Remove-NexusBlobStore -Name TreasureBlob -Force
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter()]
        [Switch]
        $Force
    )
    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/blobstores"
    }

    process {
        $Uri = $urislug + "/$Name"

        try {

           
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$name", "Remove Blob Store")) {
                    $result = Invoke-Nexus -UriSlug $Uri -Method 'DELETE' -ErrorAction Stop
                    [pscustomobject]@{
                        Status    = 'Success'
                        Blob      = $Name        
                    }
                }
            } 

            else {
                if ($PSCmdlet.ShouldProcess("$name", "Remove Blob Store")) {
                    $result = Invoke-Nexus -UriSlug $Uri -Method 'DELETE' -ErrorAction Stop
                    [pscustomobject]@{
                        Status    = 'Success'
                        Blob      = $Name
                        Timestamp = $result.date
    
                    }
                }

            }
           
            
        }

        catch {
            $_.exception.message
        }
    }
}