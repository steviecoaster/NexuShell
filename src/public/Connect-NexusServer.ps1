function Connect-NexusServer {
    [cmdletBinding()]
    param(
        [Parameter(Mandatory,Position=0)]
        [Alias('Server')]
        [String]
        $Hostname,

        [Parameter(Mandatory,Position=1)]
        [System.Management.Automation.PSCredential]
        $Credential,

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

        $credPair = "{0}:{1}" -f $Credential.UserName,$Credential.GetNetworkCredential().Password

        $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($credPair))

        $script:header = @{ Authorization = "Basic $encodedCreds"}

        try {
            $url = "$($protocol)://$($Hostname):$($port)/service/rest/v1/status"

            $params = @{
                Headers = $header
                ContentType = 'application/json'
                Method = 'GET'
                Uri = $url
            }

            $result =Invoke-RestMethod @params -ErrorAction Stop
            Write-Host "Connected to $Hostname" -ForegroundColor Green
        }

        catch {
            $_.Exception.Message
        }
    }
}