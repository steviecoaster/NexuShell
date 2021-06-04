function New-NexusAptRepository {
    [CmdletBinding(DefaultParameterSetName='Hosted')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter(Mandatory)]
        [Parameter(ParameterSetName = "Hosted")]
        [Parameter(ParameterSetName = "Proxy")]
        [ValidateSet('Hosted', 'Proxy')]
        [String]
        $Type,

        [Parameter(Mandatory)]
        [Parameter(ParameterSetName = "Hosted")]
        [Parameter(ParameterSetName = "Proxy")]

        [String]
        $Distribution,

        [Parameter(Mandatory,ParameterSetName = 'Hosted')]
        [String]
        $SigningKey,

        [Parameter(ParameterSetName = 'Hosted')]
        [String]
        $SigningKeyPassphrase,

        [Parameter(ParameterSetName = "Hosted")]
        [Parameter(ParameterSetName = "Proxy")]
        [String]
        $BlobStore = 'default',

        [Parameter(ParameterSetName = "Hosted")]
        [Parameter(ParameterSetName = "Proxy")]
        [ValidateSet('True', 'False')]
        [String]
        $StrictContentValidation = 'True',

        [Parameter(ParameterSetName = "Hosted",Mandatory)]
        [ValidateSet('Allow', 'Deny', 'Allow_Once')]
        [String]
        $DeploymentPolicy,

        [Parameter()]
        [Parameter(ParameterSetName = "Hosted")]
        [Parameter(ParameterSetName = "Proxy")]
        [String]
        $CleanupPolicy,

        [Parameter(ParameterSetName = "Hosted")]
        [Parameter(ParameterSetName = "Proxy")]
        [ValidateSet('True', 'False')]
        [String]
        $Online = 'True',

        [Parameter()]
        [Switch]
        $HasProprietaryComponents,

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
        [ValidateSet('True','False')]
        [String]
        $UseNegativeCache = 'True',

        [Parameter(ParameterSetName="Proxy")]
        [String]
        $NegativeCacheTTLMinutes = '1440',

        [Parameter(ParameterSetName='Proxy')]
        [Switch]
        $FlatUpstream = $true

    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/repositories"

        #It's 'ugly' UX to not have the types be capitalized when calling them, but the API expects them to be lowercased
        $Type = $Type.ToLower()

    }

    process {
        $formatUrl = $urislug + "/apt"

        $FullUrlSlug = $formatUrl + "/$Type"

        switch($Type){
            'Hosted' {
                $Body = @{
                    name       = $Name
                    online     = $Online
                    apt        = @{
                        distribution = $Distribution
                    }
                    aptSigning = @{
                        keypair    = $SigningKey
                        passprhase = $SigningKeyPassphrase
                    }
                    cleanup    = @{
                        policyNames = @($CleanupPolicy )
                    }
                    storage    = @{
                        strictContentTypeValidation = $StrictContentValidation
                        blobStoreName               = $BlobStore
                        writePolicy                 = $($DeploymentPolicy.ToUpper())
                    }
                }
        
                if ($HasProprietaryComponents) {
                    $Prop = @{
                        proprietaryComponents = 'True'
                    }
        
                    $Body.Add('component', $Prop)
                }
            }

            'Proxy' {
                $proxy = @{
                    remoteUrl = $ProxyRemoteUrl
                    contentMaxAge = $ContentMaxAgeMinutes
                    metadataMaxAge = $MetadataMaxAgeMinutes
                }
    
                $negCache = @{
                    enabled = $UseNegativeCache
                    timeToLive = $NegativeCacheTTLMinutes
    
                }
    
                $httpClient = @{
                    blocked        = $false 
                    autoBlock      = $true 
                }
                
                $body.Add('proxy',$proxy)
                $body.Add('negativeCache',$negCache)
                $body.Add('httpClient',$httpClient)
                $Body.apt.flat = $FlatUpstream.ToString()
            }
        }

        Write-Verbose $($Body | ConvertTo-Json)
        Invoke-Nexus -UriSlug $FullUrlSlug -Body $Body -Method POST
    }
}