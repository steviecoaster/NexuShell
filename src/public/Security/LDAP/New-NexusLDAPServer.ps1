function New-NexusLDAPServerConnection {
    <#
    .SYNOPSIS
    Creates a new LDAP Connection in Nexus
    
    .DESCRIPTION
    Creates a new LDAP connection in Nexus, allowing domain users to authenticate
    
    .PARAMETER Name
    The Name of the LDAP Connection
    
    .PARAMETER LdapProtocol
    The LDAP Protocol to use
    
    .PARAMETER UseTrustStore
    Whether to use certificates stored in Nexus Repository Manager's truststore
    
    .PARAMETER LdapHost
    LDAP server connection hostname
    
    .PARAMETER LdapPort
    Typically 389 for ldap:// and 636 for ldaps://
    
    .PARAMETER SearchBase
    LDAP location to be added to the connection URL
    
    .PARAMETER AuthenticationScheme
    Authentication scheme used for connecting to LDAP server
    
    .PARAMETER AuthenticationRealm
    The SASL realm to bind to. Required if authScheme is CRAM_MD5 or DIGEST_MD5
    
    .PARAMETER Credential
    Used to generate the authUsername and authPassword fields required when using an Authentication Scheme other than 'None'
    
    .PARAMETER ConnectionTimeoutSeconds
    How long to wait before timeout
    
    .PARAMETER RetryDelaySeconds
    How long to wait before retrying
    
    .PARAMETER MaxIncidentCount
    The number of retries before failure
    
    .PARAMETER UserBaseDN
    The relative DN where user objects are found (e.g. ou=people). This value will have the Search base DN value appended to form the full User search base DN.
    
    .PARAMETER WalkUserSubtree
    Are users located in structures below the user base DN?
    
    .PARAMETER UserObjectClass
    LDAP class for user objects
    
    .PARAMETER UserLDAPFilter
    LDAP search filter to limit user search (e.g. (|(mail=*@example.com)(uid=dom*)) )
    
    .PARAMETER UserIdAttribute
    This is used to find a user given its user ID (e.g. 'uid')
    
    .PARAMETER UserRealNameAttribute
    This is used to find a real name given the user ID (e.g. 'cn')
    
    .PARAMETER UserEmailAddressAttribute
    This is used to find an email address given the user ID (e.g. 'mail')
    
    .PARAMETER UserPasswordAttribute
    If this field is blank the user will be authenticated against a bind with the LDAP server
    
    .PARAMETER LDAPGroupsAsRoles
    Denotes whether LDAP assigned roles are used as Nexus Repository Manager roles
    
    .PARAMETER GroupType
    Defines a type of groups used: static (a group contains a list of users) or dynamic (a user contains a list of groups). Required if ldapGroupsAsRoles is true.
    
    .PARAMETER GroupBaseDN
    The relative DN where group objects are found (e.g. ou=Group). This value will have the Search base DN value appended to form the full Group search base DN.
    
    .PARAMETER WalkGroupSubtree
    Are groups located in structures below the group base DN
    
    .PARAMETER GroupObjectClass
    LDAP class for group objects. Required if groupType is static
    
    .PARAMETER GroupIdAttribute
    This field specifies the attribute of the Object class that defines the Group ID. Required if groupType is static
    
    .PARAMETER GroupMemberAttribute
    LDAP attribute containing the usernames for the group. Required if groupType is static
    
    .PARAMETER GroupMemberFormat
    The format of user ID stored in the group member attribute. Required if groupType is static (e.g. uid=${username},ou=people,dc=example,dc=com)
    
    .PARAMETER UserMemberOfAttribute
    Set this to the attribute used to store the attribute which holds groups DN in the user object. Required if groupType is dynamic (e.g. 'memberOf')
    
    .EXAMPLE
    $params = @{                                                                                                     
        Name = 'ExampleLDAPConnection'                 
        LdapProtocol = 'Ldap'                   
        LdapHost = 'domaincontroller'
        LdapPort = 389          
        SearchBase = "OU=Sales,DC=domain,DC=com"
        ConnectionTimeoutSeconds = 50           
        RetryDelaySeconds = 50 
        MaxIncidentCount = 50   
        UserBaseDN = "CN=Users,DC=domain,DC=com"
        WalkUserSubtree = $true           
        UserObjectClass = 'user'    
        UserLDAPFilter = 'phone=foo'      
        UserIdAttribute = 'samAccountName'
        UserRealNameAttribute = 'cn'
        UserEmailAddressAttribute = 'mail'
        LDAPGroupsAsRoles = $true
        GroupType = 'Dynamic'
        WalkGroupSubtree = $true
    }

    New-NexusLDAPServerConnection @params
    
    .NOTES
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Security/LDAP/New-NexusLDAPServerConnection/',DefaultParameterSetName = "default")]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter(Mandatory)]
        [ValidateSet('Ldap', 'Ldaps')]
        [String]
        $LdapProtocol,

        [Parameter()]
        [Switch]
        $UseTrustStore,

        [Parameter(Mandatory)]
        [String]
        $LdapHost,

        [Parameter(Mandatory)]
        [Int]
        $LdapPort,

        [Parameter(Mandatory)]
        [String]
        $SearchBase,

        [Parameter()]
        [Parameter(Mandatory, ParameterSetName = 'Auth')]
        [ValidateSet('None', 'Simple', 'DigestMD5', 'CramMD5')]
        [String]
        $AuthenticationScheme,

        [Parameter(Mandatory, ParameterSetName = 'Auth')]
        [Alias('Domain')]
        [String]
        $AuthenticationRealm,

        [Parameter(Mandatory, ParameterSetName = 'Auth')]
        [PSCredential]
        $Credential,

        [Parameter(Mandatory)]
        [ValidateRange(0, 3600)]
        [Int]
        $ConnectionTimeoutSeconds,

        [Parameter(Mandatory)]
        [Int]
        $RetryDelaySeconds,

        [Parameter(Mandatory)]
        [Int]
        $MaxIncidentCount,

        [Parameter(Mandatory)]
        [String]
        $UserBaseDN,

        [Parameter()]
        [Switch]
        $WalkUserSubtree,

        [Parameter(Mandatory)]
        [String]
        $UserObjectClass,

        [Parameter(Mandatory)]
        [String]
        $UserLDAPFilter,

        [Parameter()]
        [String]
        $UserIdAttribute = 'uid',

        [Parameter()]
        [String]
        $UserRealNameAttribute = 'cn',

        [Parameter()]
        [String]
        $UserEmailAddressAttribute = 'mail',

        [Parameter()]
        [String]
        $UserPasswordAttribute,

        [Parameter()]
        [Switch]
        $LDAPGroupsAsRoles,

        [Parameter()]
        [ValidateSet('Static', 'Dynamic')]
        [String]
        $GroupType = 'Static',

        [Parameter()]
        [String]
        $GroupBaseDN,

        [Parameter()]
        [Switch]
        $WalkGroupSubtree,

        [Parameter()]
        [String]
        $GroupObjectClass,

        [Parameter()]
        [String]
        $GroupIdAttribute,

        [Parameter()]
        [String]
        $GroupMemberAttribute,

        [Parameter()]
        [String]
        $GroupMemberFormat,

        [Parameter()]
        [String]
        $UserMemberOfAttribute = 'memberOf'
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

    }

    process {
        $urislug = '/service/rest/v1/security/ldap'

        $body = @{
            name                        = $Name
            protocol                    = $LdapProtocol.ToLower()
            useTrustStore               = [bool]$UseTrustStore
            host                        = $LdapHost
            port                        = $LdapPort
            searchBase                  = $SearchBase
            connectionTimeoutSeconds    = $ConnectionTimeoutSeconds
            connectionRetryDelaySeconds = $RetryDelaySeconds
            maxIncidentsCount           = $MaxIncidentCount
            userBaseDn                  = $UserBaseDN
            userSubtree                 = [bool]$WalkUserSubtree
            userObjectClass             = $UserObjectClass
            userLdapFilter              = $UserLDAPFilter
            userIdAttribute             = $UserIdAttribute
            userRealNameAttribute       = $UserRealNameAttribute
            userEmailAddressAttribute   = $UserEmailAddressAttribute
            userPasswordAttribute       = $UserPasswordAttribute
            ldapGroupsAsRoles           = [bool]$LDAPGroupsAsRoles
            groupType                   = $GroupType.ToLower()
            groupBaseDn                 = $GroupBaseDN
            groupSubtree                = [bool]$WalkGroupSubtree
            groupObjectClass            = $GroupObjectClass
            groupIdAttribute            = $GroupIdAttribute
            groupMemberAttribute        = $GroupMemberAttribute
            groupMemberFormat           = $GroupMemberFormat
            userMemberOfAttribute       = $UserMemberOfAttribute
        }

        if ($AuthenticationScheme -ne 'None' -and $null -ne $AuthenticationScheme) {
            $AuthenticationUsername = $Credential.UserName
            $AuthenticationPassword = $Credential.GetNetworkCredential().Password
        }
        switch ($AuthenticationScheme) {
            'None' { $body.Add('authScheme', 'NONE') }

            'Simple' { 
                $body.Add('authScheme', "$($AuthenticationScheme.ToUpper())")
                $body.Add('authRealm', $AuthenticationRealm)
                $body.Add('authUsername', $AuthenticationUsername)
                $body.Add('authPassword', $AuthenticationPassword)
            }

            
            'DigestMD5' { 
                $body.Add('authScheme', "$($AuthenticationScheme.ToUpper())")
                $body.Add('authRealm', $AuthenticationRealm)
                $body.Add('authUsername', $AuthenticationUsername)
                $body.Add('authPassword', $AuthenticationPassword)
            }
            
            'DigestMD5' { 
                $body.Add('authScheme', "$($AuthenticationScheme.ToUpper())")
                $body.Add('authRealm', $AuthenticationRealm)
                $body.Add('authUsername', $AuthenticationUsername)
                $body.Add('authPassword', $AuthenticationPassword)
            }

            'CramMD5' { 
                $body.Add('authScheme', "$($AuthenticationScheme.ToUpper())")
                $body.Add('authRealm', $AuthenticationRealm)
                $body.Add('authUsername', $AuthenticationUsername)
                $body.Add('authPassword', $AuthenticationPassword)
            }

            default { $body.Add('authScheme', 'NONE') }
        }

        Write-Verbose ($body | ConvertTo-Json)
        Invoke-Nexus -Urislug $urislug -Body $Body -Method POST
    }
}