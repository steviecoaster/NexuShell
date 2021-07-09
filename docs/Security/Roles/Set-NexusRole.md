---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# Set-NexusRole

## SYNOPSIS

Modifies an existing Nexus Role

## SYNTAX

```powershell
Set-NexusRole [-Role] <String> [[-Name] <String>] [[-Description] <String>] [[-Privileges] <String[]>]
 [[-Roles] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Modifies an existing Nexus Role

## EXAMPLES

### EXAMPLE 1

```powershell
Set-NexusRole -Role Example -Description "This is an updated description"
```

## PARAMETERS

### -Role

The role to modify

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

### -Name

The new name of the role

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $Role
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Update the description

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Privileges

Update privileges

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Roles

Update nested roles

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
