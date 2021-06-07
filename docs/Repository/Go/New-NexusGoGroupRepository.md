---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusGoGroupRepository

## SYNOPSIS

Creates a new Go Group repository

## SYNTAX

```powershell
New-NexusGoGroupRepository [-Name] <String> [-GroupMembers] <String[]> [-Online] [[-BlobStoreName] <String>]
 [-UseStrictContentTypeValidation] [<CommonParameters>]
```

## DESCRIPTION

Creates a new Go Group repository

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusGoGroupRepository -Name GoGroup -GroupMembers GoHostedLinux,GoProd -Online
```

## PARAMETERS

### -Name

The name of the repository

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

### -GroupMembers

Member repositories' names

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Online

Marks the repository to accept incoming requests

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

### -BlobStoreName

Blob store to use to store Go packages

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseStrictContentTypeValidation

{{ Fill UseStrictContentTypeValidation Description }}

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
