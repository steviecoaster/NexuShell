---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# Get-NexusTask

## SYNOPSIS

Gets a list of Nexus tasks

## SYNTAX

```powershell
Get-NexusTask [[-Type] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Gets a list of Nexus tasks

## EXAMPLES

### EXAMPLE 1

```powershell
Get-NexusTask
```

### EXAMPLE 2

```powershell
Get-NexusTask -Type repository.cleanup
```

## PARAMETERS

### -Type

The type of task to return

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
