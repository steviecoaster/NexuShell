function New-NexusAptProxyRepository {
    <#
    .SYNOPSIS
    Creates a new Apt Proxy Repository
    
    .DESCRIPTION
    Creates a new Apt Proxy Repository
    
    .PARAMETER Name
    The name given to the repository
    
    .PARAMETER Distribution
    Distribution to fetch e.g. bionic
    
    .PARAMETER SigningKey
    PGP signing key pair (armored private key e.g. gpg --export-secret-key --armor )
    
    .PARAMETER SigningKeyPassphrase
    Passphrase to access PGP Signing Key
    
    .PARAMETER BlobStore
    Blob store used to store repository contents
    
    .PARAMETER UseStrictContentValidation
    Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format

    .PARAMETER DeploymentPolicy
    Controls if deployments of and updates to artifacts are allowed
    
    .PARAMETER CleanupPolicy
    Components that match any of the Applied policies will be deleted
    
    .PARAMETER Online
    The repository accepts incoming requests
    
    .PARAMETER HasProprietaryComponents
    Components in this repository count as proprietary for namespace conflict attacks (requires Sonatype Nexus Firewall)
    
    .PARAMETER ProxyRemoteUrl
    Location of the remote repository being proxied
    
    .PARAMETER ContentMaxAgeMinutes
    How long (in minutes) to cache artifacts before rechecking the remote repository. Release repositories should use -1.
    
    .PARAMETER MetadataMaxAgeMinutes
    How long (in minutes) to cache metadata before rechecking the remote repository.
    
    .PARAMETER QueryCacheItemMaxAgSeconds
    How long to cache the fact that a file was not found in the repository (in minutes)
    
    .PARAMETER UseNegativeCache
    Cache responses for content not present in the proxied repository

    .PARAMETER NegativeCacheTTLMinutes
    How long to cache the fact that a file was not found in the repository (in minutes)
    
    .PARAMETER FlatUpstream
    Is this repository flat?

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
    $RepoParams = @{
        Name = 'AptProxy'
        Distribution = 'bionic'
        SigningKey = 'SuperSecretKey'
        DeploymentPolicy = 'Allow_Once'
        ProxyUrl = 'https://upstream.deb.com'
    }

    New-NexusAptProxyRepository @RepoParams
    
    .NOTES
    General notes
    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/New-NexusAptProxyRepository/',DefaultParameterSetName = 'Hosted')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter(Mandatory)]
        [String]
        $Distribution,

        [Parameter(Mandatory)]
        [String]
        $SigningKey,

        [Parameter()]
        [String]
        $SigningKeyPassphrase,

        [Parameter()]
        [String]
        $BlobStore = 'default',

        [Parameter()]
        [Switch]
        $UseStrictContentValidation,

        [Parameter(Mandatory)]
        [ValidateSet('Allow', 'Deny', 'Allow_Once')]
        [String]
        $DeploymentPolicy,

        [Parameter()]
        [String]
        $CleanupPolicy,

        [Parameter()]
        [Switch]
        $Online = $true,

        [Parameter()]
        [Switch]
        $HasProprietaryComponents,

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
        $QueryCacheItemMaxAgSeconds = '3600',

        [Parameter()]
        [Switch]
        $UseNegativeCache,

        [Parameter()]
        [String]
        $NegativeCacheTTLMinutes = '1440',

        [Parameter()]
        [Switch]
        $FlatUpstream = $true,

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
        $CustomUserAgent

    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/repositories/apt/proxy"

    }

    process {
        $Body = @{
            name          = $Name
            online        = [bool]$Online
            apt           = @{
                distribution = $Distribution
                flat = [bool]$FlatUpstream
            }
            aptSigning    = @{
                keypair    = $SigningKey
                passprhase = $SigningKeyPassphrase
            }
            cleanup       = @{
                policyNames = @($CleanupPolicy )
            }
            storage       = @{
                strictContentTypeValidation = [bool]$UseStrictContentValidation
                blobStoreName               = $BlobStore
                writePolicy                 = $($DeploymentPolicy.ToUpper())
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
            httpClient    = @{
                blocked   = [bool]$BlockOutboundConnections
                autoBlock = [bool]$EnableAutoBlocking 
            }
        }

        if ($UseAuthentication) {
            
            switch ($AuthenticationType) {
                'Username' {
                    $authentication = @{
                        type       = $AuthenticationType
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
    }
}