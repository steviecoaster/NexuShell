---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Get-NexusUser

## SYNOPSIS

Retrieve a list of users.
Note if the source is not 'default' the response is limited to 100 users.

## SYNTAX

```powershell
Get-NexusUser [[-User] <String>] [[-Source] <String>] [<CommonParameters>]
```

## DESCRIPTION

Retrieve a list of users.
Note if the source is not 'default' the response is limited to 100 users.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-NexusUser
```

### EXAMPLE 2

```powershell
Get-NexusUser -User bob
```

### EXAMPLE 3

```powershell
Get-NexusUser -Source default
```

## PARAMETERS

### -User

The username to fetch

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

The source to fetch from

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
