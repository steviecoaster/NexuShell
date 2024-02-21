function Set-NexusUser {
    <#
    .SYNOPSIS
    Update an existing user.
    
    .DESCRIPTION
    Update an existing user.
    
    .PARAMETER Username
    The userid the request should apply to.
    
    .PARAMETER FirstName
    The first name of the user.
    
    .PARAMETER LastName
    The last name of the user.
    
    .PARAMETER EmailAddress
    The email address associated with the user.
    
    .PARAMETER Source
    The user source which is the origin of this user. This value cannot be changed.
    
    .PARAMETER Status
    The user's status, e.g. active or disabled.
    
    .PARAMETER ReadOnly
    Indicates whether the user's properties could be modified by the Nexus Repository Manager. When false only roles are considered during update.
    
    .PARAMETER Roles
    The roles which the user has been assigned within Nexus.
    
    .PARAMETER ExternalRoles
    The roles which the user has been assigned in an external source, e.g. LDAP group. These cannot be changed within the Nexus Repository Manager.
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/Security/User/Set-NexusUser/')]
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusUser).UserName

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                }
                else {
                    $r
                }
            })]
        [String]
        $Username,

        [Parameter()]
        [String]
        $FirstName,

        [Parameter()]
        [String]
        $LastName,

        [Parameter()]
        [String]
        $EmailAddress,

        [Parameter()]
        [ValidateSet('Active', 'Locked', 'Disabled', 'ChangePassword')]
        [String]
        $Status,

        [Parameter()]
        [Switch]
        $ReadOnly,

        [Parameter()]
        [String[]]
        $Roles    
        )

    process {

        $user = Get-NexusUser -User $Username
        $urislug = "/service/rest/v1/security/users/$Username"

        if($Username -notin $((Get-nexusUser).Username)){
            throw "Username cannot be changed or not found in list of existing users"
        }

        switch($null){
            $FirstName { $FirstName = $user.FirstName}
            $LastName { $LastName = $user.LastName }
            $EmailAddress { $EmailAddress = $user.EmailAddress }
            $Status { $Status = $user.Status }
            $ReadOnly {[bool]$ReadOnly = $user.ReadOnly }
            $Roles { $Roles = $user.Roles}
        }

        $Body = @{
            userId = $Username
            firstName = $FirstName
            lastName = $LastName
            emailAddress = $EmailAddress
            status = $Status.ToLower()
            readOnly = [bool]$ReadOnly
            roles = $Roles
            source = $($user.Source)
        }

        Write-Verbose ($Body | ConvertTo-Json)
        Invoke-Nexus -Urislug $urislug -Body $Body -Method PUT
    }
}