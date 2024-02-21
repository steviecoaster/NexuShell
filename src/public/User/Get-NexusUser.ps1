function Get-NexusUser {
    <#
    .SYNOPSIS
    Retrieve a list of users. Note if the source is not 'default' the response is limited to 100 users.
    
    .DESCRIPTION
    Retrieve a list of users. Note if the source is not 'default' the response is limited to 100 users.
    
    .PARAMETER User
    The username to fetch
    
    .PARAMETER Source
    The source to fetch from
    
    .EXAMPLE
    Get-NexusUser
    
    .EXAMPLE
    Get-NexusUser -User bob

    .EXAMPLE
    Get-NexusUser -Source default

    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/Security/User/Get-NexusUser/')]
    Param(
        [Parameter()]
        [String]
        $User,

        [Parameter()]
        [String]
        $Source
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = '/service/rest/v1/security/users'

        if($User){
            $urislug = "/service/rest/v1/security/users?userId=$User"
        }

        if($Source){
            $urislug = "/service/rest/v1/security/users?source=$Source"
        }

        if($User -and $Source){
            $urislug = "/service/rest/v1/security/users?userId=$User&source=$Source"
        }

        $result = Invoke-Nexus -Urislug $urislug -Method GET

        $result | Foreach-Object {
            [pscustomobject]@{
                Username = $_.userId
                FirstName = $_.firstName
                LastName = $_.lastName
                EmailAddress = $_.emailAddress
                Source = $_.source
                Status = $_.status
                ReadOnly = $_.readOnly
                Roles = $_.roles
                ExternalRoles = $_.externalRoles
            }
        }
    }
}