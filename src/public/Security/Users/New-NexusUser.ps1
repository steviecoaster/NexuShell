function New-NexusUser {
    <#
    .SYNOPSIS
    Create a new user in the default source.
    
    .DESCRIPTION
    Create a new user in the default source.
    
    .PARAMETER Username
    The userid which is required for login. This value cannot be changed.
    
    .PARAMETER Password
    The password for the new user.
    
    .PARAMETER FirstName
    The first name of the user.
    
    .PARAMETER LastName
    The last name of the user.
    
    .PARAMETER EmailAddress
    The email address associated with the user.
    
    .PARAMETER Status
    The user's status, e.g. active or disabled.
    
    .PARAMETER Roles
    The roles which the user has been assigned within Nexus.
    
    .EXAMPLE
    $params = @{
        Username = 'jimmy'
        Password = ("sausage" | ConvertTo-SecureString -AsPlainText -Force)
        FirstName = 'Jimmy'
        LastName = 'Dean'
        EmailAddress = 'sausageking@jimmydean.com'
        Status = Active
        Roles = 'nx-admin'
    }

    New-NexusUser @params
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Security/User/New-NexusUser/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Username,

        [Parameter(Mandatory)]
        [SecureString]
        $Password,

        [Parameter(Mandatory)]
        [String]
        $FirstName,

        [Parameter(Mandatory)]
        [String]
        $LastName,

        [Parameter(Mandatory)]
        [String]
        $EmailAddress,

        [Parameter(Mandatory)]
        [ValidateSet('Active', 'Locked', 'Disabled', 'ChangePassword')]
        [String]
        $Status,

        [Parameter(Mandatory)]
        [ArgumentCompleter({
            param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)
            (Get-NexusRole).Id.Where{$_ -like "*$WordToComplete*"}
        })]
        [String[]]
        $Roles
    )

    process {
        $urislug = '/service/rest/v1/security/users'

        $Body = @{
            userId       = $Username
            firstName    = $FirstName
            lastName     = $LastName
            emailAddress = $EmailAddress
            password     = [System.Net.NetworkCredential]::new($Username, $Password).Password
            status       = $Status
            roles        = $Roles
        }

        Write-Verbose ($Body | ConvertTo-Json)
        $result = Invoke-Nexus -Urislug $urislug -Body $Body -Method POST

        [pscustomObject]@{
            Username      = $result.userId
            FirstName     = $result.firstName
            LastName      = $result.lastName
            EmailAddress  = $result.emailAddress
            Source        = $result.source
            Status        = $result.status
            Roles         = $result.roles
            ExternalRoles = $result.externalRoles
        }
    }
}