---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusUser

## SYNOPSIS

Create a new user in the default source.

## SYNTAX

```powershell
New-NexusUser [-Username] <String> [-Password] <SecureString> [-FirstName] <String> [-LastName] <String>
 [-EmailAddress] <String> [-Status] <String> [-Roles] <String[]> [<CommonParameters>]
```

## DESCRIPTION

Create a new user in the default source.

## EXAMPLES

### EXAMPLE 1

```powershell
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
```

## PARAMETERS

### -Username

The userid which is required for login.
This value cannot be changed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password

The password for the new user.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FirstName

The first name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastName

The last name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailAddress

The email address associated with the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

The user's status, e.g. active or disabled.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Roles

The roles which the user has been assigned within Nexus.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
