---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Set-NexusReadOnlyMode

## SYNOPSIS

Sets the nexus instance Read-Only mode

## SYNTAX

### Enable (Default)

```powershell
Set-NexusReadOnlyMode [-Enable] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Disable

```
Set-NexusReadOnlyMode [-Disable] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Either Disable or Enable Read-Only mode of your nexus instance

## EXAMPLES

### EXAMPLE 1

```powershell
Set-NexusReadOnlyMode -Enable
```

### EXAMPLE 2

```powershell
Set-NexusReadOnlyMode -Disable
```

## PARAMETERS

### -Enable

Sets the nexus instance to Read-Only mode

```yaml
Type: SwitchParameter
Parameter Sets: Enable
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disable

Sets the nexus instance to write-enabled mode

```yaml
Type: SwitchParameter
Parameter Sets: Disable
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

{{ Fill Force Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Disable
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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
