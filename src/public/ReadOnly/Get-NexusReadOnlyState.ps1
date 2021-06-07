function Get-NexusReadOnlyState {
    <#
    .SYNOPSIS
    Returns the Read-Only state of the nexus instance
    
    .DESCRIPTION
    Returns the Read-Only state of the nexus instance
    
    .EXAMPLE
    Get-NexusReadOnlyState
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Get-NexusReadOnlyState/')]
    Param()
    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/read-only"
    }

    process {

        Invoke-Nexus -UriSlug $urislug -Method 'GET'
    }
}