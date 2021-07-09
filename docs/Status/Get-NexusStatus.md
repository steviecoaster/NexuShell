---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# Get-NexusStatus

## SYNOPSIS

Returns Nexus System Status information

## SYNTAX

```powershell
Get-NexusStatus [-VerifyRead] [-VerifySystem] [-VerifyWrite] [<CommonParameters>]
```

## DESCRIPTION

Returns Nexus System Status information

## EXAMPLES

### EXAMPLE 1

```powershell
Get-NexusStatus
```

Returns system information

### EXAMPLE 2

```powershell
Get-NexusStatus -VerifyRead
```

### EXAMPLE 3

```powershell
Get-NexusStatus -VerifySystem
```

### EXAMPLE 4

```powershell
Get-NexusStatus -VerifyWrite
```

### EXAMPLE 5

```powershell
Get-NexusStatus -VerifyRead -VerifyWrite -VerifySystem
```

## PARAMETERS

### -VerifyRead

Verifies that Nexus can accept read requests

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

### -VerifySystem

Returns system information

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

### -VerifyWrite

Verifies that Nexus can accpet write requests

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
