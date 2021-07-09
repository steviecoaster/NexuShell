---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusRole

## SYNOPSIS

Creates a new Nexus Role

## SYNTAX

```powershell
New-NexusRole [-Id] <String> [-Name] <String> [[-Description] <String>] [-Privileges] <String[]>
 [[-Roles] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Creates a new Nexus Role

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusRole -Id SamepleRole
```

### EXAMPLE 2

```powershell
New-NexusRole -Id SampleRole -Description "A sample role" -Privileges nx-all
```

## PARAMETERS

### -Id

The ID of the role

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

The friendly name of the role

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

A description of the role

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

Included privileges for the role

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Roles

Included nested roles

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
