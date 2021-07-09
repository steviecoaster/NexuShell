---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusRoutingRule

## SYNOPSIS
Create a new Nexus routing rule

## SYNTAX

```
New-NexusRoutingRule [-Name] <String> [[-Description] <String>] [-Mode] <String> [-Matchers] <String[]>
 [<CommonParameters>]
```

## DESCRIPTION

Create a new Nexus routing rule

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusRoutingRule -Name BlockNuGet -Mode Block -Matchers 'NuGet','[\w]Nuget.+'
```

## PARAMETERS

### -Name

The name of the rule

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

### -Description

A brief explanation of the routing rule

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

### -Mode

Allow the connection, or block the connection

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Matchers

Regex strings to match for the route

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
