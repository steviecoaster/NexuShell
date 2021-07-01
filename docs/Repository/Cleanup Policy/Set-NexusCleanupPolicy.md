---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Set-NexusCleanupPolicy

## SYNOPSIS

Updates a Nexus Cleanup Policy

## SYNTAX

```powershell
Set-NexusCleanupPolicy [-Name] <String> [[-Format] <String>] [[-Notes] <String>] [[-ComponentAge] <Int32>]
 [[-ComponentUsage] <Int32>] [[-AssetMatcher] <String>] [<CommonParameters>]
```

## DESCRIPTION

Updates a Nexus Cleanup Policy

## EXAMPLES

### EXAMPLE 1

```powershell
Set-NexusCleanupPolicy -Name TestPol -Notes "New notes here" -ComponentAge 60
```

## PARAMETERS

### -Name

The cleanup policy to update

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

### -Format

The format that this cleanup policy can be applied to

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

### -Notes

Additional details about the policy

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

### -ComponentAge

Remove components that were published over this many days

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComponentUsage

Remove components that haven't been downloaded in this many days

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetMatcher

Remove components that have at least one asset name matching the following regular expression pattern

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
