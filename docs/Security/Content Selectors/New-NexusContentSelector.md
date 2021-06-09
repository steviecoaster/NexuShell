---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusContentSelector

## SYNOPSIS

Creates a new Content Selector in Nexus

## SYNTAX

```powershell
New-NexusContentSelector [-Name] <String> [[-Description] <String>] [-Expression] <String> [<CommonParameters>]
```

## DESCRIPTION

Creates a new Content Selector in Nexus

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusContentSelector -Name MavenContent -Expression 'format == "maven2" and path =^ "/org/sonatype/nexus"'
```

## PARAMETERS

### -Name

The content selector name cannot be changed after creation

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

### -Description

A human-readable description

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

### -Expression

The expression used to identify content

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
