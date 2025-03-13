function New-NexusDockerProxyRepository {
    <#
    .SYNOPSIS
    Creates a new Conda Proxy Repository

    .DESCRIPTION
    Creates a new Conda Proxy Repository

    .PARAMETER Name
    The name to give the repository

    .PARAMETER ProxyRemoteUrl
    Location of the remote repository being proxied, e.g. https://api.Conda.org/v3/index.json

    .PARAMETER ContentMaxAgeMinutes
    Time before cached content is refreshed. Defaults to 1440

    .PARAMETER MetadataMaxAgeMinutes
    Time before cached metadata is refreshed. Defaults to 1440

    .PARAMETER UseNegativeCache
    Use the built-in Negative Cache feature

    .PARAMETER NegativeCacheTTLMinutes
    The Negative Cache Time To Live value. Defaults to 1440

    .PARAMETER CleanupPolicy
    The Cleanup Policy to apply to this repository

    .PARAMETER RoutingRule
    Routing Rules you wish to apply to this repository

    .PARAMETER Online
    Mark the repository as Online. Defaults to True

    .PARAMETER BlobStoreName
    The back-end blob store in which to store cached packages

    .PARAMETER UseStrictContentValidation
    Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format

    .PARAMETER UseNexusTrustStore
    Use certificates stored in the Nexus truststore to connect to external systems

    .PARAMETER UseAuthentication
    Use authentication for the upstream repository

    .PARAMETER AuthenticationType
    The type of authentication required by the upstream repository

    .PARAMETER Credential
    Credentials to use to connecto to upstream repository

    .PARAMETER HostnameFqdn
    If using NTLM authentication, the Hostname of the NTLM host to query

    .PARAMETER DomainName
    The domain name of the NTLM host

    .PARAMETER BlockOutboundConnections
    Block outbound connections on the repository

    .PARAMETER EnableAutoBlocking
    Auto-block outbound connections on the repository if remote peer is detected as unreachable/unresponsive

    .PARAMETER ConnectionRetries
    Connection attempts to upstream repository before a failure

    .PARAMETER ConnectionTimeoutSeconds
    Amount of time to wait before retrying the connection to the upstream repository

    .PARAMETER EnableCircularRedirects
    Enable redirects to the same location (may be required by some servers)

    .PARAMETER EnableCookies
    Allow cookies to be stored and used

    .PARAMETER CustomUserAgent
    Custom fragment to append to "User-Agent" header in HTTP requests

    .PARAMETER EnableV1
    Whether to allow clients to use the V1 API to interact with this repository
    
    .PARAMETER ForceBasicAuth
    Whether to force authentication (Docker Bearer Token Realm required if false)
    
    .PARAMETER HttpPort
    Create an HTTP connector at specified port
    
    .PARAMETER HttpsPort
    Create an HTTPS connector at specified port

    .PARAMETER ProxyIndexType
    Type of Docker Index

    .PARAMETER IndexUrl
    Url of Docker Index to use. Required only if ProxyIndexType is Custom
    
    .EXAMPLE
    New-NexusDockerProxyRepository -Name DockerProxyTest -ProxyRemoteUrl https://hub.docker.io -Online
    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/New-NexusDockerProxyRepository/',DefaultParameterSetName = "Default")]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter()]
        [Switch]
        $Online,

        [Parameter()]
        [String]
        $BlobStoreName = 'default',

        [Parameter()]
        [Switch]
        $UseStrictContentValidation,

        [Parameter()]
        [String]
        $CleanupPolicy,

        [Parameter(Mandatory)]
        [String]
        $ProxyRemoteUrl,

        [Parameter()]
        [String]
        $ContentMaxAgeMinutes = '1440',

        [Parameter()]
        [String]
        $MetadataMaxAgeMinutes = '1440',

        [Parameter()]
        [Switch]
        $UseNegativeCache,

        [Parameter()]
        [String]
        $NegativeCacheTTLMinutes = '1440',

        [Parameter()]
        [String]
        $RoutingRule,

        [Parameter()]
        [Switch]
        $UseNexusTrustStore = $false,

        [Parameter(ParameterSetName = "Authentication")]
        [Switch]
        $UseAuthentication,

        [Parameter(ParameterSetName = "Authentication", Mandatory)]
        [ValidateSet('Username', 'NTLM')]
        [String]
        $AuthenticationType,

        [Parameter(ParameterSetName = "Authentication", Mandatory)]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter(ParameterSetName = "Authentication")]
        [String]
        $HostnameFqdn,

        [Parameter(ParameterSetName = "Authentication")]
        [String]
        $DomainName,

        [Parameter()]
        [Switch]
        $BlockOutboundConnections = $false,

        [Parameter()]
        [Switch]
        $EnableAutoBlocking = $false,

        [Parameter()]
        [ValidateRange(0, 10)]
        [String]
        $ConnectionRetries,

        [Parameter()]
        [String]
        $ConnectionTimeoutSeconds,

        [Parameter()]
        [Switch]
        $EnableCircularRedirects = $false,

        [Parameter()]
        [Switch]
        $EnableCookies = $false,

        [Parameter()]
        [String]
        $CustomUserAgent,

        [Parameter()]
        [Switch]
        $EnableV1,

        [Parameter()]
        [Switch]
        $ForceBasicAuth,

        [Parameter()]
        [String]
        $HttpPort,
        
        [Parameter()]
        [String]
        $HttpsPort,

        [Parameter()]
        [ValidateSet('Hub', 'Registry', 'Custom')]
        [String]
        $ProxyIndexType = 'Registry',

        [Parameter()]
        [String]
        $IndexUrl
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    
        $urislug = "/service/rest/v1/repositories/docker/proxy"
    
    }
    
    process {

        if($ProxyIndexType -eq 'Hub'){
            $IndexUrl = 'https://index.docker.io/'
        }

        if($ProxyIndexType -eq 'Custom'){
            if($null -eq $IndexUrl){
                throw "IndexUrl is required when using a custom ProxyIndexType"
            }
        }

        switch($ProxyIndexType){
            'Hub' { $IndexUrl = 'https://index.docker.io/'}
            'Registry' {$IndexUrl = $ProxyRemoteUrl}
            default {$null}
        }

        $body = @{
            name          = $Name
            online        = [bool]$Online
            storage       = @{
                blobStoreName               = $BlobStoreName
                strictContentTypeValidation = [bool]$StrictContentValidation
                writePolicy                 = $DeploymentPolicy
            }
            cleanup       = @{
                policyNames = @($CleanupPolicy)
            }
            proxy         = @{
                remoteUrl      = $ProxyRemoteUrl
                contentMaxAge  = $ContentMaxAgeMinutes
                metadataMaxAge = $MetadataMaxAgeMinutes
            }
            negativeCache = @{
                enabled    = [bool]$UseNegativeCache
                timeToLive = $NegativeCacheTTLMinutes
            }
            routingRule   = $RoutingRule
            httpClient    = @{
                blocked    = [bool]$BlockOutboundConnections
                autoBlock  = [bool]$EnableAutoBlocking
                connection = @{
                    retries                 = $ConnectionRetries
                    userAgentSuffix         = $CustomUserAgent
                    timeout                 = $ConnectionTimeoutSeconds
                    enableCircularRedirects = [bool]$EnableCircularRedirects
                    enableCookies           = [bool]$EnableCookies
                    useTrustStore           = [bool]$UseNexusTrustStore
                }
            }
            docker        = @{
                v1Enabled      = [bool]$EnableV1
                forceBasicAuth = [bool]$ForceBasicAuth
                httpPort       = $HttpPort
                httpsPort      = $HttpsPort
            }
            dockerProxy   = @{
                indexType = $ProxyIndexType.ToUpper()
                indexUrl  = $IndexUrl
            }
    
        }
    
        if ($UseAuthentication) {
            
            switch ($AuthenticationType) {
                'Username' {
                    $authentication = @{
                        type       = $AuthenticationType.ToLower()
                        username   = $Credential.UserName
                        password   = $Credential.GetNetworkCredential().Password
                        ntlmHost   = ''
                        ntlmDomain = ''
                    }
        
                    $body.httpClient.Add('authentication', $authentication)
                }
    
                'NTLM' {
                    if (-not $HostnameFqdn -and $DomainName) {
                        throw "Parameter HostnameFqdn and DomainName are required when using WindowsNTLM authentication"
                    }
                    else {
                        $authentication = @{
                            type       = $AuthenticationType
                            username   = $Credential.UserName
                            password   = $Credential.GetNetworkCredential().Password
                            ntlmHost   = $HostnameFqdn
                            ntlmDomain = $DomainName
                        }
                    }
       
                    $body.httpClient.Add('authentication', $authentication)
                }
            }
            
        }

        Write-Verbose $($Body | ConvertTo-Json)
        $null = Invoke-Nexus -UriSlug $urislug -Body $Body -Method POST

        if ($ForceBasicAuth -eq $false) {
            Write-Warning "Docker Bearer Token Realm required since -ForceBasicAuth was not passed."
            Write-Warning "Use Add-NexusRealm to enable if desired."
        }

    }
}