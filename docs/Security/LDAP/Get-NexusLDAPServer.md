---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Get-NexusLDAPServer

## SYNOPSIS
Returns a list of conigured LDAP sources

## SYNTAX

```
Get-NexusLDAPServer [[-Name] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Returns a list of configured LDAP sources.
Annoyingly...it does not include the name

## EXAMPLES

### EXAMPLE 1
```
Get-NexusLDAPServer
```

### EXAMPLE 2
```
Get-NexusLDAPServer -Name ActiveDirectoryConnection
```

## PARAMETERS

### -Name
The name of the LDAP source to retrieve.
You'll have to know this value, as it isn't returned by the API
when you run wthis command without any parameters

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
