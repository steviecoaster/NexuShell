function Switch-NexusLdapOrder {
    <#
    .SYNOPSIS
    Reorders LDAP Server priority if there are multiple
    
    .DESCRIPTION
    Reorders LDAP Server priority if there are multiple
    
    .PARAMETER NewOrder
    The new order of LDAP Server Names. You can't retrieve these via API, so you'll need to look in the web interface or know what they are
    
    .EXAMPLE
    Switch-NexusLdapOrder -NewOrder ProductionLDAP,EuropeLDAP,AsiaLDAP
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Security/LDAP/Switch-NexusLdapOrder/')]
    Param(
        [Parameter(Mandatory)]
        [Array]
        $NewOrder
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

    }

    process {
        $urislug = '/service/rest/v1/security/ldap/change-order'
        Invoke-Nexus -Urislug $urislug -BodyAsArray $NewOrder -Method POST
    }
}