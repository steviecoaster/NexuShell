---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Remove-NexusPrivilege

## SYNOPSIS

Remove a Nexus Privilege

## SYNTAX

```powershell
Remove-NexusPrivilege [-PrivilegeId] <String[]> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Remove a Nexus Privilege

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-NexusPrivilege -PrivilegeId NuGetSuperAdmin
```

### EXAMPLE 2

```powershell
Get-NexusPrivilege -PrivilegeId NuGetSuperAdmin | Remove-NexusPrivilege
```

### EXAMPLE 3

```powershell
Remove-NexusPrivilege -PrivilegeId NuGetSuperAdmin -Force
```

## PARAMETERS

### -PrivilegeId

The id of the privilege to delete.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Force

Don't prompt for confirmation before removal

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
