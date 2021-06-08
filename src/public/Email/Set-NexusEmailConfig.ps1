function Set-NexusEmailConfig {
    <#
    .SYNOPSIS
    Sets the email settings for Nexus
    
    .DESCRIPTION
    Sets the email settings for Nexus
    
    .PARAMETER SmtpServer
    The hostname or IP address of your mail server
    
    .PARAMETER SmtpPort
    The SMTP port of your mail server
    
    .PARAMETER Enabled
    Enable sending mail from Nexus
    
    .PARAMETER Credential
    Credentials to connect to your SMTP server if required
    
    .PARAMETER FromAddress
    Messages from Nexus with be sent from this email address
    
    .PARAMETER SubjectPrefix
    Append a prefix to messages from Nexus if desired
    
    .PARAMETER StartTlsEnabled
    Enable StartTLS
    
    .PARAMETER StartTlsRequired
    Require TLS on the smtp connection
    
    .PARAMETER SSLOnConnect
    Require SSL on the smtp connection
    
    .PARAMETER VerifyServerIdentity
    Verify mail server identity before sending messages
    
    .PARAMETER UseNexusTrustStore
    Use Nexus Trust Store for email certificates
    
    .EXAMPLE
    Set-NexusEmailConfig -SmtpSerer mail.foo.org -Port 25 -Enabled

    .EXAMPLE
    Set-NexusEmailConfig -SmtpServer mail.foo.org -Port 427 -Enabled -StartTlsEnabled -StartTlsrequired
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter()]
        [String]
        $SmtpServer,

        [Parameter(Mandatory)]
        [Int32]
        $SmtpPort,

        [Parameter()]
        [Switch]
        $Enabled,

        [Parameter()]
        [PSCredential]
        $Credential,

        [Parameter()]
        [String]
        $FromAddress,

        [Parameter()]
        [String]
        $SubjectPrefix,

        [Parameter()]
        [Switch]
        $StartTlsEnabled,

        [Parameter()]
        [Switch]
        $StartTlsRequired,

        [Parameter()]
        [Switch]
        $SSLOnConnect,

        [Parameter()]
        [Switch]
        $VerifyServerIdentity,

        [Parameter()]
        [Switch]
        $UseNexusTrustStore
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = '/service/rest/v1/email'

        if($Credential){
            $username = $Credential.UserName
            $password = $Credential.GetNetworkCredential().Password
        }

        $Body = @{
            enabled= [bool]$Enabled
            host= $SmtpServer
            port= $SmtpPort
            username= $username
            password= $password
            fromAddress= $FromAddress
            subjectPrefix= $SubjectPrefix
            startTlsEnabled= [bool]$StartTlsEnabled
            startTlsRequired= [bool]$StartTlsRequired
            sslOnConnectEnabled= [bool]$SSLOnConnect
            sslServerIdentityCheckEnabled= [bool]$VerifyServerIdentity
            nexusTrustStoreEnabled= [bool]$UseNexusTrustStore
          }

          Write-verbose ($Body | ConvertTo-Json)
          Invoke-Nexus -Urislug $urislug -Body $Body -Method PUT
    }
}