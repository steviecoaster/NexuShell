function New-NexusNugetProxyRepository {
<#
.SYNOPSIS
Creates a new NuGet Proxy Repository

.DESCRIPTION
Creates a new NuGet Proxy Repository

.PARAMETER Name
The name to give the repository

.PARAMETER ProxyRemoteUrl
Location of the remote repository being proxied, e.g. https://api.nuget.org/v3/index.json

.PARAMETER ContentMaxAgeMinutes
Time before cached content is refreshed. Defaults to 1440

.PARAMETER MetadataMaxAgeMinutes
Time before cached metadata is refreshed. Defaults to 1440

.PARAMETER QueryCacheItemMaxAgeSeconds
Time before the query cache expires. Defaults to 3600

.PARAMETER NugetVersion
Upstream NuGet version. Can either be V2 or V3

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

.PARAMETER StrictContentValidation
Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format

.PARAMETER DeploymentPolicy
Controls whether packages can be overwritten

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

.EXAMPLE

$ProxyParameters = @{
    Name = 'ChocoProxy'
    ProxyRemoteUrl = 'https://community.chocolatey.org/api/v2'
    NugetVersion = 'V2'
    DeploymentPolicy = 'Allow'

}

New-NexusNugetProxyRepository @ProxyParameters

.EXAMPLE

$ProxyParameters = @{
    Name = 'ChocoProxy'
    ProxyRemoteUrl = 'https://community.chocolatey.org/api/v2'
    NugetVersion = 'V2'
    DeploymentPolicy = 'Allow'
    UseAuthentication = $true
    AuthenticationType = 'Username'
    Credential = (Get-Credential)

}

New-NexusNugetProxyRepository @ProxyParameters
#>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/New-NexusNugetProxyRepository/',DefaultParameterSetname="Default")]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

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
        [String]
        $QueryCacheItemMaxAgeSeconds = '3600',

        [Parameter(Mandatory)]
        [ValidateSet('V2', 'V3')]
        [String]
        $NugetVersion,

        [Parameter()]
        [Switch]
        $UseNegativeCache,

        [Parameter()]
        [String]
        $NegativeCacheTTLMinutes = '1440',

        [Parameter()]
        [String]
        $CleanupPolicy,

        [Parameter()]
        [String]
        $RoutingRule,

        [Parameter()]
        [Switch]
        $Online = $true,

        [Parameter()]
        [String]
        $BlobStoreName = 'default',

        [Parameter()]
        [Switch]
        $StrictContentValidation = $true,

        [Parameter()]
        [ValidateSet('Allow', 'Deny', 'Allow_Once')]
        [String]
        $DeploymentPolicy,

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
        [ValidateRange(0,10)]
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
        $CustomUserAgent
    )
    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/repositories"

    }
    process {
        $formatUrl = $urislug + "/nuget"

        $FullUrlSlug = $formatUrl + "/proxy"

        $AuthenticationType = $AuthenticationType.ToLower()

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

            nugetProxy    = @{
                queryCacheItemMaxAge = $QueryCacheItemMaxAgSeconds
                nugetVersion         = $NugetVersion
            }

            negativeCache = @{
                enabled    = [bool]$UseNegativeCache
                timeToLive = $NegativeCacheTTLMinutes
            }

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
    
        }

        if ($UseAuthentication) {
            
            switch($AuthenticationType){
                'Username' {
                    $authentication = @{
                        type       = $AuthenticationType
                        username   = $Credential.UserName
                        password   = $Credential.GetNetworkCredential().Password
                        ntlmHost = ''
                        ntlmDomain = ''
                    }
        
                    $body.httpClient.Add('authentication', $authentication)
                }

                'NTLM' {
                    if(-not $HostnameFqdn -and $DomainName){
                        throw "Parameter HostnameFqdn and DomainName are required when using WindowsNTLM authentication"
                    } else {
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
        $null = Invoke-Nexus -UriSlug $FullUrlSlug -Body $Body -Method POST

    }
}