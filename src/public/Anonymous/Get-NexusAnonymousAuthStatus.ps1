function Get-NexusAnonymousAuthStatus {
    <#
    .SYNOPSIS
    Returns the state of Nexus Anonymous Auth
    
    .DESCRIPTION
    Returns the state of Nexus Anonymous Auth
    
    .EXAMPLE
    Get-NexusAnonymousAuth
    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/Get-NexusAnonymousAuthStatus/')]
    Param()

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/security/anonymous"
    }
    process {

        Invoke-Nexus -UriSlug $urislug -Method 'GET'
    }
}