---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Get-NexusBlobStore

## SYNOPSIS
Get information about a blob store

## SYNTAX

### Default (Default)
```
Get-NexusBlobStore [<CommonParameters>]
```

### Name
```
Get-NexusBlobStore -Name <String> -Type <String> [-Detailed] [<CommonParameters>]
```

### Type
```
Get-NexusBlobStore -Type <String> [-Detailed] [<CommonParameters>]
```

## DESCRIPTION
Get basic or detailed blob store configuration information

## EXAMPLES

### EXAMPLE 1
```
Get-NexusBlobStore
```

### EXAMPLE 2
```
Get-NexusBlobStore -Name default -Type file
```

### EXAMPLE 3
```
Get-NexusBlobStore -Name TreasureBlob -Type file -Detailed
```

## PARAMETERS

### -Name
The blob store to get information from

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
The type of the blob store

```yaml
Type: String
Parameter Sets: Name, Type
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Detailed
Return detailed information about the blob store

```yaml
Type: SwitchParameter
Parameter Sets: Name, Type
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
