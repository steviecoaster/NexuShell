function New-NexusGoGroupRepository {
    <#
    .SYNOPSIS
    Creates a new Go Group repository

    .DESCRIPTION
    Creates a new Go Group repository
    
    .PARAMETER Name
    The name of the repository
    
    .PARAMETER Online
    Marks the repository to accept incoming requests
    
    .PARAMETER BlobStoreName
    Blob store to use to store Go packages
    
    .PARAMETER StrictContentValidation
    Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format
    
    .PARAMETER GroupMembers
    Member repositories' names

    .EXAMPLE
    New-NexusGoGroupRepository -Name GoGroup -GroupMembers GoHostedLinux,GoProd -Online
    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/New-NexusGoGroupRepository/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter(Mandatory)]
        [String[]]
        $GroupMembers,

        [Parameter()]
        [Switch]
        $Online,

        [Parameter()]
        [String]
        $BlobStoreName = 'default',

        [Parameter()]
        [Switch]
        $UseStrictContentTypeValidation
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    
        $urislug = "/service/rest/v1/repositories/go/group"
    
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
        }

        Write-Verbose $($Body | ConvertTo-Json)
        $null = Invoke-Nexus -UriSlug $urislug -Body $Body -Method POST
    }

}