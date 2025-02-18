function New-NexusNugetHostedRepository {
    <#
    .SYNOPSIS
    Creates a new NuGet Hosted repository
    
    .DESCRIPTION
    Creates a new NuGet Hosted repository
    
    .PARAMETER Name
    The name of the repository
    
    .PARAMETER CleanupPolicy
    The Cleanup Policies to apply to the repository
    

    
    .PARAMETER Online
    Marks the repository to accept incoming requests
    
    .PARAMETER BlobStoreName
    Blob store to use to store NuGet packages
    
    .PARAMETER StrictContentValidation
    Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format
    
    .PARAMETER DeploymentPolicy
    Controls if deployments of and updates to artifacts are allowed
    
    .PARAMETER HasProprietaryComponents
    Components in this repository count as proprietary for namespace conflict attacks (requires Sonatype Nexus Firewall)
    
    .EXAMPLE
    New-NexusNugetHostedRepository -Name NugetHostedTest -DeploymentPolicy Allow

    .EXAMPLE

    $RepoParams = @{
        Name = MyNuGetRepo
        CleanupPolicy = '90 Days'
        DeploymentPolicy = 'Allow'
        UseStrictContentValidation = $true
    }
    
    New-NexusNugetHostedRepository @RepoParams

    .NOTES
    General notes
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/New-NexusNugetHostedRepository/')]
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
        $HasProprietaryComponents
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/repositories"

    }

    process {
        $formatUrl = $urislug + '/nuget'

        $FullUrlSlug = $formatUrl + '/hosted'


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
        }

        if ($HasProprietaryComponents) {
            $Prop = @{
                proprietaryComponents = 'True'
            }
    
            $Body.Add('component', $Prop)
        }

        Write-Verbose $($Body | ConvertTo-Json)
        $null = Invoke-Nexus -UriSlug $FullUrlSlug -Body $Body -Method POST

    }
}