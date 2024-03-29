function Remove-NexusLDAPServerConnection {
    <#
    .SYNOPSIS
    Renove LDAP Connection from Nexus
    
    .DESCRIPTION
    Renove LDAP Connection from Nexus
    
    .PARAMETER Name
    The LDAP Connection you wish to remove

    .PARAMETER Force
    Don't prompt for confirmation
    
    .EXAMPLE
    Remove-NexusLDAPServerConnection -Name DevLDAP

    .EXAMPLE
    Remove-NexusLDAPServerConnection -Name DevLDAP -Force
    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/Security/LDAP/Remove-NexusLDAPServerConnection/',SupportsShouldProcess,ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [String[]]
        $Name,

        [Parameter()]
        [Switch]
        $Force
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }


    }

    process {

        $Name | ForEach-Object {
            $urislug = "/service/rest/v1/security/ldap/$_"

            try {
           
                if ($Force -and -not $Confirm) {
                    $ConfirmPreference = 'None'
                    if ($PSCmdlet.ShouldProcess("$_", "Remove LDAP Connection")) {
                        Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                        
                    }
                }
                else {
                    if ($PSCmdlet.ShouldProcess("$_", "Remove LDAP Connection")) {
                        Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                    }
                }
            }
    
            catch {
                $_.exception.message
            }
    

        }

    }
}