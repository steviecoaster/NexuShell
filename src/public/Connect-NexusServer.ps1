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

    .PARAMETER LocalService
    Connects to a locally running instance of Nexus, if it can be found

    .EXAMPLE
    Connect-NexusServer -LocalService -Credential admin

    .EXAMPLE
    Connect-NexusServer -LocalService -Credential admin -Hostname nexus.fabrikam.com

    .EXAMPLE
    Connect-NexusServer -Hostname nexus.fabrikam.com -Credential (Get-Credential)

    .EXAMPLE
    Connect-NexusServer -Hostname nexus.fabrikam.com -Credential (Get-Credential) -UseSSL

    .EXAMPLE
    Connect-NexusServer -Hostname nexus.fabrikam.com -Credential $Cred -UseSSL -Sslport 443
    #>
    [CmdletBinding(DefaultParameterSetName="Specified", HelpUri='https://nexushell.dev/Connect-NexusServer/')]
    param(
        [Parameter(ParameterSetName="Specified", Mandatory, Position=0)]
        [Parameter(ParameterSetName="LocalService", Position=0)]
        [Alias('Server')]
        [String]
        $Hostname,

        [Parameter(Mandatory, Position=1)]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter(ParameterSetName="Specified")]
        [String]
        $Path = "/",

        [Parameter(ParameterSetName="Specified")]
        [Switch]
        $UseSSL,

        [Parameter(ParameterSetName="Specified")]
        [String]
        $Sslport = '8443',

        [Parameter(ParameterSetName="LocalService", Mandatory)]
        [Switch]
        $LocalService
    )
    end {
        $credPair = "{0}:{1}" -f $Credential.UserName,$Credential.GetNetworkCredential().Password

        $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($credPair))

        $script:header = @{ Authorization = "Basic $encodedCreds" }
        $script:Credential = $Credential

        switch ($PSCmdlet.ParameterSetName) {
            "Specified" {
                if($UseSSL){
                    $script:protocol = 'https'
                    $script:port = $Sslport
                } else {
                    $script:protocol = 'http'
                    $script:port = '8081'
                }

                $script:HostName = $Hostname
                $script:ContextPath = $Path.TrimEnd('/')

                $uri = "$($protocol)://$($Hostname):$($port)$($ContextPath)"
            }
            "LocalService" {
                $UriArgs = @{}
                if ($Hostname) {
                    $UriArgs.HostnameOverride = $Hostname
                }
                [uri]$uri = Get-NexusUri @UriArgs

                $script:protocol = $uri.Scheme
                $script:port = $uri.Port
                $script:HostName = $uri.Host
                $script:ContextPath = $uri.LocalPath.TrimEnd('/')
            }
        }

        $params = @{
            Headers = $header
            ContentType = 'application/json'
            Method = 'GET'
            Uri = "$($uri.ToString().TrimEnd('/'))/service/rest/v1/status"
            UseBasicParsing = $true
        }

        try {
            $null = Invoke-RestMethod @params -ErrorAction Stop
            Write-Host "Connected to $($script:HostName)" -ForegroundColor Green
        } catch {
            $_.Exception.Message
        }
    }
}