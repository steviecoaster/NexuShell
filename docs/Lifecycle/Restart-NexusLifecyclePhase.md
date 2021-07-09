---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# Restart-NexusLifecyclePhase

## SYNOPSIS

Re-runs all phases from the given phase to the current phase

## SYNTAX

```powershell
Restart-NexusLifecyclePhase [-Phase] <String> [<CommonParameters>]
```

## DESCRIPTION

Re-runs all phases from the given phase to the current phase

## EXAMPLES

### EXAMPLE 1

```powershell
Restart-NexusLifecyclePhase -Phase 'SomePreviousPhase'
```

## PARAMETERS

### -Phase

The phase to bounce

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
