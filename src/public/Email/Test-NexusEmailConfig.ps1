function Test-NexusEmailConfig {
    <#
    .SYNOPSIS
    Verifies Nexus Smtp configuration
    
    .DESCRIPTION
    Verifies Nexus Smtp configuration
    
    .PARAMETER Recipient
    Email address to send test message too
    
    .EXAMPLE
    Test-NexusEmailConfig -Recipient tim@foo.org
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Recipient
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = '/service/rest/v1/email/verify'

        Invoke-Nexus -Urislug $urislug -BodyAsString $Recipient -Method POST
    }
}