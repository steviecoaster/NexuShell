---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Set-NexusUser

## SYNOPSIS

Update an existing user.

## SYNTAX

```powershell
Set-NexusUser [-Username] <String> [[-FirstName] <String>] [[-LastName] <String>] [[-EmailAddress] <String>]
 [[-Status] <String>] [-ReadOnly] [[-Roles] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Update an existing user.

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

The userid the request should apply to.

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

### -FirstName

The first name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

Required: False
Position: 3
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

Required: False
Position: 4
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

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReadOnly

Indicates whether the user's properties could be modified by the Nexus Repository Manager.
When false only roles are considered during update.

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

### -Roles

The roles which the user has been assigned within Nexus.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
