function Get-NexusLDAPServerConnection {
    <#
    .SYNOPSIS
    Returns a list of conigured LDAP sources
    
    .DESCRIPTION
    Returns a list of configured LDAP sources. Annoyingly...it does not include the name
    
    .PARAMETER Name
    The name of the LDAP source to retrieve. You'll have to know this value, as it isn't returned by the API
    when you run wthis command without any parameters
    
    .EXAMPLE
    Get-NexusLDAPServerConnection

    .EXAMPLE
    Get-NexusLDAPServerConnection -Name ActiveDirectoryConnection
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Security/LDAP/Get-NexusLDAPServerConnection/')]
    Param(
        [Parameter()]
        [String[]]
        $Name
    )
    
    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

    }

    process {

        if (-not $Name) {
            $urislug = '/service/rest/v1/security/ldap'
            $result = Invoke-Nexus -Urislug $urislug -Method GET
            
            [pscustomobject]@{
                Protocol                    = $result.protocol
                UseTrustStore               = $result.useTrustStore
                Host                        = $result.host
                Port                        = $result.port
                SearchBase                  = $result.searchBase
                AuthScheme                  = $result.authScheme
                AuthRealm                   = $result.authRealm
                AuthUsername                = $result.authUsername
                ConnectionTimeoutSeconds    = $result.connectionTimeoutSeconds
                ConnectionRetryDelaySeconds = $result.connectionRetryDelaySeconds
                MaxIncidentsCount           = $result.maxIncidentsCount
                UserBaseDn                  = $result.userBaseDn
                UserSubtree                 = $result.userSubtree
                UserObjectClass             = $result.userObjectClass
                UserLdapFilter              = $result.userLdapFilter
                UserIdAttribute             = $result.userIdAttribute
                UserRealNameAttribute       = $result.userRealNameAttribute
                UserEmailAddressAttribute   = $result.userEmailAddressAttribute
                UserPasswordAttribute       = $result.userPasswordAttribute
                LdapGroupsAsRoles           = $result.ldapGroupsAsRoles
                GroupType                   = $result.groupType
                GroupBaseDn                 = $result.groupBaseDn
                GroupSubtree                = $result.groupSubtree
                GroupObjectClass            = $result.groupObjectClass
                GroupIdAttribute            = $result.groupIdAttribute
                GroupMemberAttribute        = $result.groupMemberAttribute
                GroupMemberFormat           = $result.groupMemberFormat
                UserMemberOfAttribute       = $result.userMemberOfAttribute
                Id                          = $result.id
                Order                       = $result.order
            }
        }
        else {
            $Name | Foreach-Object {
                $urislug = "/service/rest/v1/security/ldap/$_"
                $result = Invoke-Nexus -Urislug $urislug -Method GET
                $result | Foreach-Object {
                    [pscustomobject]@{
                        Protocol                    = $_.protocol
                        UseTrustStore               = $_.useTrustStore
                        Host                        = $_.host
                        Port                        = $_.port
                        SearchBase                  = $_.searchBase
                        AuthScheme                  = $_.authScheme
                        AuthRealm                   = $_.authRealm
                        AuthUsername                = $_.authUsername
                        ConnectionTimeoutSeconds    = $_.connectionTimeoutSeconds
                        ConnectionRetryDelaySeconds = $_.connectionRetryDelaySeconds
                        MaxIncidentsCount           = $_.maxIncidentsCount
                        UserBaseDn                  = $_.userBaseDn
                        UserSubtree                 = $_.userSubtree
                        UserObjectClass             = $_.userObjectClass
                        UserLdapFilter              = $_.userLdapFilter
                        UserIdAttribute             = $_.userIdAttribute
                        UserRealNameAttribute       = $_.userRealNameAttribute
                        UserEmailAddressAttribute   = $_.userEmailAddressAttribute
                        UserPasswordAttribute       = $_.userPasswordAttribute
                        LdapGroupsAsRoles           = $_.ldapGroupsAsRoles
                        GroupType                   = $_.groupType
                        GroupBaseDn                 = $_.groupBaseDn
                        GroupSubtree                = $_.groupSubtree
                        GroupObjectClass            = $_.groupObjectClass
                        GroupIdAttribute            = $_.groupIdAttribute
                        GroupMemberAttribute        = $_.groupMemberAttribute
                        GroupMemberFormat           = $_.groupMemberFormat
                        UserMemberOfAttribute       = $_.userMemberOfAttribute
                        Id                          = $_.id
                        Order                       = $_.order
                    }
        
                }
            }
        }
    }
}