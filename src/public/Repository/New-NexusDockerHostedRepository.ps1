function New-NexusDockerHostedRepository {
    <#
    .SYNOPSIS
    Creates a new Docker Hosted repository
    
    .DESCRIPTION
    Creates a new Docker Hosted repository
    
    .PARAMETER Name
    The name of the repository
    
    .PARAMETER CleanupPolicy
    The Cleanup Policies to apply to the repository
    
    .PARAMETER Online
    Marks the repository to accept incoming requests
    
    .PARAMETER BlobStoreName
    Blob store to use to store Docker packages
    
    .PARAMETER StrictContentValidation
    Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format
    
    .PARAMETER DeploymentPolicy
    Controls if deployments of and updates to artifacts are allowed
    
    .PARAMETER HasProprietaryComponents
    Components in this repository count as proprietary for namespace conflict attacks (requires Sonatype Nexus Firewall)
    
    .PARAMETER EnableV1
    Whether to allow clients to use the V1 API to interact with this repository
    
    .PARAMETER ForceBasicAuth
    Whether to force authentication (Docker Bearer Token Realm required if false)
    
    .PARAMETER HttpPort
    Create an HTTP connector at specified port
    
    .PARAMETER HttpsPort
    Create an HTTPS connector at specified port
    
    .EXAMPLE
    New-NexusDockerHostedRepository -Name DockerHostedTest -DeploymentPolicy Allow -EnableV1 -ForceBasicAuth

    .EXAMPLE

    $RepoParams = @{
        Name = MyDockerRepo
        CleanupPolicy = '90 Days'
        DeploymentPolicy = 'Allow'
        UseStrictContentValidation = $true
        ForceBasicAuth = $true
        HttpPort = '8082'
        EnableV1 = $true
    }
    
    New-NexusDockerHostedRepository @RepoParams

    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/New-NexusDockerHostedRepository/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter()]
        [String]
        $CleanupPolicy,

        [Parameter()]
        [Switch]
        $Online = $true,

        [Parameter()]
        [String]
        $BlobStoreName = 'default',

        [Parameter()]
        [ValidateSet('True', 'False')]
        [String]
        $UseStrictContentValidation = 'True',

        [Parameter()]
        [ValidateSet('Allow', 'Deny', 'Allow_Once')]
        [String]
        $DeploymentPolicy,

        [Parameter()]
        [Switch]
        $HasProprietaryComponents,

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
        $HttpsPort
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    
        $urislug = "/service/rest/v1/repositories/docker/hosted"
    
    }

    
    process {

        $body = @{
            name    = $Name
            online  = [bool]$Online
            storage = @{
                blobStoreName               = $BlobStoreName
                strictContentTypeValidation = $UseStrictContentValidation
                writePolicy                 = $DeploymentPolicy
            }
            cleanup = @{
                policyNames = @($CleanupPolicy)
            }
            docker = @{
                v1Enabled = [bool]$EnableV1
                forceBasicAuth = [bool]$ForceBasicAuth
                httpPort = $HttpPort
                httpsPort = $HttpsPort
            }

        }

        if ($HasProprietaryComponents) {
            $Prop = @{
                proprietaryComponents = 'True'
            }
    
            $Body.Add('component', $Prop)
        }


        Write-Verbose $($Body | ConvertTo-Json)
        $null = Invoke-Nexus -UriSlug $urislug -Body $Body -Method POST

        if($ForceBasicAuth -eq $false){
            Write-Warning "Docker Bearer Token Realm required since -ForceBasicAuth was not passed."
            Write-Warning "Use Add-NexusRealm to enable if desired."
        }
    
    }
}