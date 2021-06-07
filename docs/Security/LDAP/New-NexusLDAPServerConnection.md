---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusLDAPServerConnection

## SYNOPSIS

Creates a new LDAP Connection in Nexus

## SYNTAX

### default (Default)

```powershell
New-NexusLDAPServerConnection -Name <String> -LdapProtocol <String> [-UseTrustStore] -LdapHost <String>
 -LdapPort <Int32> -SearchBase <String> [-AuthenticationScheme <String>] -ConnectionTimeoutSeconds <Int32>
 -RetryDelaySeconds <Int32> -MaxIncidentCount <Int32> -UserBaseDN <String> [-WalkUserSubtree]
 -UserObjectClass <String> -UserLDAPFilter <String> [-UserIdAttribute <String>]
 [-UserRealNameAttribute <String>] [-UserEmailAddressAttribute <String>] [-UserPasswordAttribute <String>]
 [-LDAPGroupsAsRoles] [-GroupType <String>] [-GroupBaseDN <String>] [-WalkGroupSubtree]
 [-GroupObjectClass <String>] [-GroupIdAttribute <String>] [-GroupMemberAttribute <String>]
 [-GroupMemberFormat <String>] [-UserMemberOfAttribute <String>] [<CommonParameters>]
```

### Auth

```powershell
New-NexusLDAPServerConnection -Name <String> -LdapProtocol <String> [-UseTrustStore] -LdapHost <String>
 -LdapPort <Int32> -SearchBase <String> -AuthenticationScheme <String> -AuthenticationRealm <String>
 -Credential <PSCredential> -ConnectionTimeoutSeconds <Int32> -RetryDelaySeconds <Int32>
 -MaxIncidentCount <Int32> -UserBaseDN <String> [-WalkUserSubtree] -UserObjectClass <String>
 -UserLDAPFilter <String> [-UserIdAttribute <String>] [-UserRealNameAttribute <String>]
 [-UserEmailAddressAttribute <String>] [-UserPasswordAttribute <String>] [-LDAPGroupsAsRoles]
 [-GroupType <String>] [-GroupBaseDN <String>] [-WalkGroupSubtree] [-GroupObjectClass <String>]
 [-GroupIdAttribute <String>] [-GroupMemberAttribute <String>] [-GroupMemberFormat <String>]
 [-UserMemberOfAttribute <String>] [<CommonParameters>]
```

## DESCRIPTION

Creates a new LDAP connection in Nexus, allowing domain users to authenticate

## EXAMPLES

### EXAMPLE 1

```powershell
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
```

## PARAMETERS

### -Name

The Name of the LDAP Connection

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LdapProtocol

The LDAP Protocol to use

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseTrustStore

Whether to use certificates stored in Nexus Repository Manager's truststore

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LdapHost

LDAP server connection hostname

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LdapPort

Typically 389 for ldap:// and 636 for ldaps://

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchBase

LDAP location to be added to the connection URL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthenticationScheme

Authentication scheme used for connecting to LDAP server

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Auth
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthenticationRealm

The SASL realm to bind to.
Required if authScheme is CRAM_MD5 or DIGEST_MD5

```yaml
Type: String
Parameter Sets: Auth
Aliases: Domain

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Used to generate the authUsername and authPassword fields required when using an Authentication Scheme other than 'None'

```yaml
Type: PSCredential
Parameter Sets: Auth
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConnectionTimeoutSeconds

How long to wait before timeout

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryDelaySeconds

How long to wait before retrying

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxIncidentCount

The number of retries before failure

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserBaseDN

The relative DN where user objects are found (e.g.
ou=people).
This value will have the Search base DN value appended to form the full User search base DN.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WalkUserSubtree

Are users located in structures below the user base DN?

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserObjectClass

LDAP class for user objects

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserLDAPFilter

LDAP search filter to limit user search (e.g.
(|(mail=*@example.com)(uid=dom*)) )

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserIdAttribute

This is used to find a user given its user ID (e.g.
'uid')

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Uid
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserRealNameAttribute

This is used to find a real name given the user ID (e.g.
'cn')

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Cn
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserEmailAddressAttribute

This is used to find an email address given the user ID (e.g.
'mail')

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Mail
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserPasswordAttribute

If this field is blank the user will be authenticated against a bind with the LDAP server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LDAPGroupsAsRoles

Denotes whether LDAP assigned roles are used as Nexus Repository Manager roles

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupType

Defines a type of groups used: static (a group contains a list of users) or dynamic (a user contains a list of groups).
Required if ldapGroupsAsRoles is true.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Static
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupBaseDN

The relative DN where group objects are found (e.g.
ou=Group).
This value will have the Search base DN value appended to form the full Group search base DN.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WalkGroupSubtree

Are groups located in structures below the group base DN

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupObjectClass

LDAP class for group objects.
Required if groupType is static

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupIdAttribute

This field specifies the attribute of the Object class that defines the Group ID.
Required if groupType is static

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupMemberAttribute

LDAP attribute containing the usernames for the group.
Required if groupType is static

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupMemberFormat

The format of user ID stored in the group member attribute.
Required if groupType is static (e.g.
uid=${username},ou=people,dc=example,dc=com)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserMemberOfAttribute

Set this to the attribute used to store the attribute which holds groups DN in the user object.
Required if groupType is dynamic (e.g.
'memberOf')

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: MemberOf
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
