---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusCleanupPolicy

## SYNOPSIS

Create a new Nexus Cleanup Policy

## SYNTAX

### Default (Default)

```powershell
New-NexusCleanupPolicy -Name <String> -Format <String> [-Notes <String>] [<CommonParameters>]
```

### Usage

```powershell
New-NexusCleanupPolicy -Name <String> -Format <String> [-Notes <String>] -ComponentUsage <Int32>
 [-AssetMatcher <String>] [<CommonParameters>]
```

### Age

```powershell
New-NexusCleanupPolicy -Name <String> -Format <String> [-Notes <String>] -ComponentAge <Int32>
 [-AssetMatcher <String>] [<CommonParameters>]
```

## DESCRIPTION

Create a new Nexus Cleanup Policy

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusCleanupPolicy -Name SamplePol -Format nuget -ComponentAge 180
```

### EXAMPLE 2

```powershell
New-NexusCleanupPolicy -Name SamplePol -Format Go -ComponentUsage 90 -AssetMatcher '*.+'
```

## PARAMETERS

### -Name

Unique name for the cleanup policy

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format

The format that this cleanup policy can be applied to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notes

Additional details about the policy

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComponentAge

Remove components that were published over this many days

```yaml
Type: Int32
Parameter Sets: Age
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComponentUsage

Remove components that haven't been downloaded in this many days

```yaml
Type: Int32
Parameter Sets: Usage
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetMatcher

Remove components that have at least one asset name matching the following regular expression pattern

```yaml
Type: String
Parameter Sets: Usage, Age
Aliases:

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
