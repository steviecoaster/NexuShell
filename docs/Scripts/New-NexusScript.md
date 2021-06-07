---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusScript

## SYNOPSIS

Stores a new script in Nexus

## SYNTAX

```powershell
New-NexusScript [-Name] <String> [-Content] <String> [-Type] <String> [<CommonParameters>]
```

## DESCRIPTION

Stores a new script in Nexus

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusScript -Name TestScript -Content 'Get-ComputerInfo' -Type powershell
```

## PARAMETERS

### -Name

The name of the script

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

### -Content

The contents of the script

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type

The language of the script

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
