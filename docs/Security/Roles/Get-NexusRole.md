---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# Get-NexusRole

## SYNOPSIS

Retrieve Nexus Role information

## SYNTAX

```powershell
Get-NexusRole [[-Role] <String>] [[-Source] <String>] [<CommonParameters>]
```

## DESCRIPTION

Retrieve Nexus Role information

## EXAMPLES

### EXAMPLE 1

```powershell
Get-NexusRole
```

### EXAMPLE 2

```powershell
Get-NexusRole -Role ExampleRole
```

## PARAMETERS

### -Role

The role to retrieve

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

The source to retrieve from

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
