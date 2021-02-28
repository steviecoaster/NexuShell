function New-NexusRepository {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter(Mandatory)]
        [ValidateSet('apt','bower','cocoapods','conan','conda','docker','gitlfs','go','helm','maven2','npm','nuget','p2','pypi','r','raw','rubygems','yum')]
        [String]
        $Format,

        [Parameter(Mandatory)]
        [Parameter(Mandatory,ParameterSetName="Group")]
        [Parameter(Mandatory,ParameterSetName="Hosted")]
        [Parameter(Mandatory,ParameterSetName="Proxy")]
        [ValidateSet('hosted','proxy','group')]
        [String]
        $Type,

        [Parameter(Mandatory,ParameterSetName="Group")]
        [String[]]
        $GroupMember,

        [Parameter(Mandatory,ParameterSetName="Proxy")]
        [String]
        $ProxyRemoteUrl,

        [Parameter(ParameterSetName="Proxy")]
        [String]
        $ContentMaxAgeMinutes = '1440',

        [Parameter(ParameterSetName="Proxy")]
        [String]
        $MetadataMaxAgeMinutes = '1440',

        [Parameter(ParameterSetName="Proxy")]
        [String]
        $QueryCacheItemMaxAgSeconds = '3600',

        [Parameter(ParameterSetName="Proxy")]
        [String]
        $NugetVersion = 'V3',

        [Parameter(ParameterSetName="Proxy")]
        [ValidateSet('True','False')]
        [String]
        $UseNegativeCache = 'True',

        [Parameter(ParameterSetName="Proxy")]
        [String]
        $NegativeCacheTTLMinutes = '1440',

        [Parameter(ParameterSetName="Group")]
        [Parameter(ParameterSetName="Hosted")]
        [Parameter(ParameterSetName="Proxy")]
        [String]
        $CleanupPolicy,

        [Parameter(ParameterSetName="Group")]
        [Parameter(ParameterSetName="Hosted")]
        [Parameter(ParameterSetName="Proxy")]
        [String]
        $RoutingRule,

        [Parameter(ParameterSetName="Group")]
        [Parameter(ParameterSetName="Hosted")]
        [Parameter(ParameterSetName="Proxy")]
        [ValidateSet('True','False')]
        [String]
        $Online = 'True',

        [Parameter(ParameterSetName="Group")]
        [Parameter(ParameterSetName="Hosted")]
        [Parameter(ParameterSetName="Proxy")]
        [String]
        $BlobStoreName = 'default',

        [Parameter(ParameterSetName="Group")]
        [Parameter(ParameterSetName="Hosted")]
        [Parameter(ParameterSetName="Proxy")]
        [ValidateSet('True','False')]
        [String]
        $StrictContentValidation = 'True',

        [Parameter(ParameterSetName="Hosted")]
        [Parameter(ParameterSetName="Proxy")]
        [ValidateSet('Allow','Deny','Allow_Once')]
        [String]
        $DeploymentPolicy
    )

    begin {

        if(-not $header){
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/repositories"

    }

    process {
        $formatUrl = $urislug + "/$Format"

        $FullUrlSlug = $formatUrl + "/$Type"

        switch ($PSCmdlet.ParameterSetName){
            'Group' {}
            'Hosted' {
                $Body = @{
                    name          = $Name
                    online        = $Online
                    cleanup       = @{
                        policyNames = @($CleanupPolicy )
                    }
                    storage       = @{
                        strictContentTypeValidation = $StrictContentValidation
                        blobStoreName               = $BlobStoreName
                        writePolicy = $($DeploymentPolicy.ToUpper())
                    }
                }

                Write-Verbose $($Body | ConvertTo-Json)
                Invoke-Nexus -UriSlug $FullUrlSlug -Body $Body -Method POST

            }
            'Proxy' {

               $Body = @{
                    name          = $Name
                    proxy         = @{
                        remoteUrl = $ProxyRemoteUrl
                        metadataMaxAge  = $MetadataMaxAgeMinutes
                        contentMaxAge   = $ContentMaxAgeMinutes 
                    }
                    online        = $Online
                    nugetProxy    = @{
                        nugetVersion         = $NugetVersion
                        queryCacheItemMaxAge = $QueryCacheItemMaxAgSeconds
                    }
                    negativeCache = @{
                        enabled    = $UseNegativeCache
                        timeToLive = $NegativeCacheTTLMinutes
                    }
                    httpClient    = @{
                        blocked        = $false 
                        autoBlock      = $true 
                        <#connection     = @{
                            retries = 0
                            userAgentSuffix = ''
                            timeout = 60
                            enableCircularRedirects = $false
                            enableCookies = $false
                        }#>
                        <#authentication = @{
                            type = "username"
                            username = ''
                            ntlmHost = ''
                            ntlmDomain = ''
                        }
                        #>
                    }
                    cleanup       = @{
                        policyNames = @($CleanupPolicy )
                    }
                    storage       = @{
                        strictContentTypeValidation = $StrictContentValidation
                        blobStoreName               = $BlobStoreName 
                    }
                }

                Write-Verbose $($Body | ConvertTo-Json)
                Invoke-Nexus -UriSlug $FullUrlSlug -Body $Body -Method POST

            }
        }
        
    }
}