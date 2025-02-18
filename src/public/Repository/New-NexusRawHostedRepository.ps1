function New-NexusRawHostedRepository {
    <#
    .SYNOPSIS
    Creates a new Raw Hosted repository
    
    .DESCRIPTION
    Creates a new Raw Hosted repository
    
    .PARAMETER Name
    The Name of the repository to create
    
    .PARAMETER Online
    Mark the repository as Online. Defaults to True
    
    .PARAMETER BlobStore
    The blob store to attach the repository too. Defaults to 'default'
    
    .PARAMETER UseStrictContentTypeValidation
    Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format
    
    .PARAMETER DeploymentPolicy
    Controls if deployments of and updates to artifacts are allowed
    
    .PARAMETER CleanupPolicy
    Components that match any of the Applied policies will be deleted
    
    .PARAMETER HasProprietaryComponents
    Components in this repository count as proprietary for namespace conflict attacks (requires Sonatype Nexus Firewall)
    
    .PARAMETER ContentDisposition
    Add Content-Disposition header as 'Attachment' to disable some content from being inline in a browser.
    
    .EXAMPLE
    New-NexusRawHostedRepository -Name BinaryArtifacts -ContentDisposition Attachment

    .EXAMPLE
    $RepoParams = @{
        Name = 'BinaryArtifacts'
        Online = $true
        UseStrictContentTypeValidation = $true
        DeploymentPolicy = 'Allow'
        CleanupPolicy = '90Days',
        BlobStore = 'AmazonS3Bucket'
    }

    New-NexusRawHostedRepository @RepoParams
    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/New-NexusRawHostedRepository/', DefaultParameterSetname = "Default")]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter()]
        [Switch]
        $Online = $true,

        [Parameter()]
        [String]
        $BlobStore = 'default',

        [Parameter()]
        [Switch]
        $UseStrictContentTypeValidation,

        [Parameter()]
        [ValidateSet('Allow', 'Deny', 'Allow_Once')]
        [String]
        $DeploymentPolicy = 'Allow_Once',

        [Parameter()]
        [String]
        $CleanupPolicy,

        [Parameter()]
        [Switch]
        $HasProprietaryComponents,

        [Parameter(Mandatory)]
        [ValidateSet('Inline','Attachment')]
        [String]
        $ContentDisposition
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/repositories/raw/hosted"

    }

    process {

        $Body = @{
            name = $Name
            online = [bool]$Online
            storage = @{
                blobStoreName = $BlobStore
                strictContentTypeValidation = [bool]$UseStrictContentTypeValidation
                writePolicy = $DeploymentPolicy.ToLower()
            }
            cleanup = @{
                policyNames = @($CleanupPolicy)
            }
            component = @{
                proprietaryComponents = [bool]$HasProprietaryComponents
            }
            raw = @{
                contentDisposition = $ContentDisposition.ToUpper()
            }
        }

        Write-Verbose $($Body | ConvertTo-Json)
        $null = Invoke-Nexus -UriSlug $urislug -Body $Body -Method POST


    }
}