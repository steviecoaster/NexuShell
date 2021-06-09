---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Stop-NexusTask

## SYNOPSIS

Stops a running Nexus Task

## SYNTAX

```powershell
Stop-NexusTask [-Task] <String> [<CommonParameters>]
```

## DESCRIPTION

Stops a running Nexus Task

## EXAMPLES

### EXAMPLE 1

```powershell
Stop-NexusTask -Task 'Cleanup Service'
```

## PARAMETERS

### -Task

The task to stop

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
