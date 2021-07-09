function Connect-NexusServer {
    <#
    .SYNOPSIS
    Creates the authentication header needed for REST calls to your Nexus server
    
    .DESCRIPTION
    Creates the authentication header needed for REST calls to your Nexus server
    
    .PARAMETER Hostname
    The hostname or ip address of your Nexus server
    
    .PARAMETER Credential
    The credentials to authenticate to your Nexus server

    .PARAMETER Path
    The optional context path used by the Nexus server
    
    .PARAMETER UseSSL
    Use https instead of http for REST calls. Defaults to 8443.
    
    .PARAMETER Sslport
    If not the default 8443 provide the current SSL port your Nexus server uses
    
    .EXAMPLE
    Connect-NexusServer -Hostname nexus.fabrikam.com -Credential (Get-Credential)

    .EXAMPLE
    Connect-NexusServer -Hostname nexus.fabrikam.com -Credential (Get-Credential) -UseSSL

    .EXAMPLE
    Connect-NexusServer -Hostname nexus.fabrikam.com -Credential $Cred -UseSSL -Sslport 443
    #>
    [cmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Connect-NexusServer/')]
    param(
        [Parameter(Mandatory,Position=0)]
        [Alias('Server')]
        [String]
        $Hostname,

        [Parameter(Mandatory,Position=1)]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [String]
        $Path = "/",

        [Parameter()]
        [Switch]
        $UseSSL,

        [Parameter()]
        [String]
        $Sslport = '8443'
    )

    process {

        if($UseSSL){
            $script:protocol = 'https'
            $script:port = $Sslport
        } else {
            $script:protocol = 'http'
            $script:port = '8081'
        }

        $script:HostName = $Hostname
        $script:ContextPath = $Path.TrimEnd('/')

        $credPair = "{0}:{1}" -f $Credential.UserName,$Credential.GetNetworkCredential().Password

        $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($credPair))

        $script:header = @{ Authorization = "Basic $encodedCreds"}

        try {
            $url = "$($protocol)://$($Hostname):$($port)$($ContextPath)/service/rest/v1/status"

            $params = @{
                Headers = $header
                ContentType = 'application/json'
                Method = 'GET'
                Uri = $url
                UseBasicParsing = $true
            }

            $result = Invoke-RestMethod @params -ErrorAction Stop
            Write-Host "Connected to $Hostname" -ForegroundColor Green
        }

        catch {
            $_.Exception.Message
        }
    }
}