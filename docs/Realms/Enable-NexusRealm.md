---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Enable-NexusRealm

## SYNOPSIS

Enable realms in Nexus

## SYNTAX

```powershell
Enable-NexusRealm [-Realm] <String[]> [<CommonParameters>]
```

## DESCRIPTION

Enable realms in Nexus

## EXAMPLES

### EXAMPLE 1

```powershell
Enable-NexusRealm -Realm 'NuGet Api-Key Realm', 'Rut Auth Realm'
```

### EXAMPLE 2

```powershell
Enable-NexusRealm -Realm 'LDAP Realm'
```

## PARAMETERS

### -Realm

The realms you wish to activate

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
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
