function Get-NexusUserToken {
    <#
    .SYNOPSIS
    Fetches a User Token for the provided credential
    
    .DESCRIPTION
    Fetches a User Token for the provided credential
    
    .PARAMETER Credential
    The Nexus user for which to receive a token
    
    .NOTES
    This is a private function not exposed to the end user. 
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [PSCredential]
        $Credential
    )

    process {
        $UriBase = "$($protocol)://$($Hostname):$($port)$($ContextPath)"
        
        $slug = '/service/extdirect'

        $uri = $UriBase + $slug

        $data = @{
            action = 'rapture_Security'
            method = 'authenticationToken'
            data   = @("$([System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($($Credential.Username))))", "$([System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($($Credential.GetNetworkCredential().Password))))")
            type   = 'rpc'
            tid    = 16 
        }

        Write-Verbose ($data | ConvertTo-Json)
        $result = Invoke-RestMethod -Uri $uri -Method POST -Body ($data | ConvertTo-Json) -ContentType 'application/json' -Headers $header -UseBasicParsing
        $token = $result.result.data
        $token
    }

}