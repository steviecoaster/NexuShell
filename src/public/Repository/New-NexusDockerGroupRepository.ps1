function New-NexusDockerGroupRepository {
    <#
    .SYNOPSIS
    Creates a new Docker Group repository

    .DESCRIPTION
    Creates a new Docker Group repository
    
    .PARAMETER Name
    The name of the repository
    
    .PARAMETER Online
    Marks the repository to accept incoming requests
    
    .PARAMETER BlobStoreName
    Blob store to use to store Docker packages
    
    .PARAMETER StrictContentValidation
    Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format
    
    .PARAMETER EnableV1
    Whether to allow clients to use the V1 API to interact with this repository
    
    .PARAMETER ForceBasicAuth
    Whether to force authentication (Docker Bearer Token Realm required if false)
    
    .PARAMETER HttpPort
    Create an HTTP connector at specified port
    
    .PARAMETER HttpsPort
    Create an HTTPS connector at specified port
    
    .EXAMPLE
    New-NexusDockerGroupRepository -Name DockerGroup -GroupMembers DockerHostedLinux,DockerProd -Online
    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/New-NexusDockerGroupRepository/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter(Mandatory)]
        [String[]]
        $GroupMembers,

        [Parameter()]
        [String]
        $WritableMember,

        [Parameter()]
        [Switch]
        $Online = $true,

        [Parameter()]
        [String]
        $BlobStoreName = 'default',

        [Parameter()]
        [Switch]
        $UseStrictContentTypeValidation,

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
    
        $urislug = "/service/rest/v1/repositories/docker/group"
    
    }

    process {

        $body = @{
            name    = $Name
            online  = [bool]$Online
            storage = @{
                blobStoreName               = $BlobStoreName
                strictContentTypeValidation = [bool]$UseStrictContentValidation
            }
            group   = @{
                memberNames = $GroupMembers
                writableMember = $WritableMember
            }
            docker = @{
                v1Enabled = [bool]$EnableV1
                forceBasicAuth = [bool]$ForceBasicAuth
                httpPort = $HttpPort
                httpsPort = $HttpsPort
            }
        }

        Write-Verbose $($Body | ConvertTo-Json)
        $null = Invoke-Nexus -UriSlug $urislug -Body $Body -Method POST

        if($ForceBasicAuth -eq $false){
            Write-Warning "Docker Bearer Token Realm required since -ForceBasicAuth was not passed."
            Write-Warning "Use Add-NexusRealm to enable if desired."
        }


    }

}