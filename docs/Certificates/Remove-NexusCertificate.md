---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# Remove-NexusCertificate

## SYNOPSIS

Remove a certificate in the trust store.

## SYNTAX

```powershell
Remove-NexusCertificate [-Thumbprint] <String> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Remove a certificate in the trust store.

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-NexusCertificate -Thumbprint 1a:25:25:25:93:85:94
```

### EXAMPLE 2

```powershell
Remove-NexusCertificate -Thumbprint 1a:25:25:25:93:85:94 -Force
```

### EXAMPLE 3

```powershell
Get-NexusCertificate | Remove-NexusCertificate
```

## PARAMETERS

### -Thumbprint

The id of the certificate that should be removed.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Force

Don't prompt before removing

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
