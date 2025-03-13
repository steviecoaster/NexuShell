function New-NexusRepository {
    <#
    .SYNOPSIS
    Creates a new repository in your Nexus server
    
    .DESCRIPTION
    Creates a new repository of the specified type and settings in your Nexus server
    
    .PARAMETER Name
    The name to give to the new repository
    
    .PARAMETER Format
    The format of the new repository
    
    .PARAMETER Type
    The type of repository to create: Hosted,Group,Proxy
    
    .PARAMETER GroupMember
    Members to add to group repository types. Must be of the same repository format as the repository you are creating
    
    .PARAMETER ProxyRemoteUrl
    When setting a Proxy type repository, this is the upstream repository url to point the new repository
    
    .PARAMETER ContentMaxAgeMinutes
    When using a Proxy type repository, the length of time to cache package contents before reaching back out to the upstream url
    
    .PARAMETER MetadataMaxAgeMinutes
    When using a Proxy type repository, the length of time to cache package metadata before reaching back out to the upstream url
    
    .PARAMETER QueryCacheItemMaxAgSeconds
    When using a Proxy type repository, the length of time to cache upstream url repsonses
    
    .PARAMETER NugetVersion
    For Nuget proxy repositories the version of nuget packages your upstream url contains
    
    .PARAMETER UseNegativeCache
    Use Negative Cache for proxy url
    
    .PARAMETER NegativeCacheTTLMinutes
    The Negative Cache TTL value
    
    .PARAMETER CleanupPolicy
    The cleanup policy to apply to the new repository
    
    .PARAMETER RoutingRule
    The Routing Rule to apply to the new repository
    
    .PARAMETER Online
    Make the new repository immediately available for use. This basically means "Enabled", or "Disabled"
    
    .PARAMETER BlobStoreName
    The blob store to use with the new repository
    
    .PARAMETER StrictContentValidation
    Specify that uploaded artifacts adhere to the MIME type of the specified format
    
    .PARAMETER DeploymentPolicy
    Controls whether you can push the same package version repeatedly, or push packages at all
    
    .EXAMPLE
    New-NexusRepository -Name NugetCenter -Format nuget -Type hosted -DeploymentPolicy Allow
    
    .EXAMPLE
    New-NexusRepository -Name ChocoUpstream -Format nuget -Type proxy -ProxyRemoteUrl 'https://chocolatey.org/api/v2'
    #>
    [CmdletBinding(HelpUri='https://github.com/steviecoaster/NexuShell/blob/develop/docs/New-NexusRepository.md')]
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
                $null = Invoke-Nexus -UriSlug $FullUrlSlug -Body $Body -Method POST

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
                $null = Invoke-Nexus -UriSlug $FullUrlSlug -Body $Body -Method POST

            }
        }
        
    }
}