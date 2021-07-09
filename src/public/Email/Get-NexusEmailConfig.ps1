function Get-NexusEmailConfig {
    <#
    .SYNOPSIS
    Gets current Nexus email configuration
    
    .DESCRIPTION
    Gets current Nexus email configuration
    
    .EXAMPLE
    Get-NexusEmailConfig
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param()

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = '/service/rest/v1/email'

        $result = Invoke-Nexus -Urislug $urislug -Method GET

        [pscustomobject]@{
            Enabled                       = $result.enabled
            Host                          = $result.host
            Port                          = $result.port
            Username                      = $result.username
            Password                      = $result.password
            FromAddress                   = $result.fromaddress
            SubjectPrefix                 = $result.subjectprefix
            StartTlsEnabled               = $result.starttlsenabled
            StartTlsRequired              = $result.starttlsrequired
            SslOnConnectEnabled           = $result.sslonconnectenabled
            SslServerIdentityCheckEnabled = $result.sslserveridentitycheckenabled
            NexusTrustStoreEnabled        = $result.nexustruststoreenabled
        }
    }
}