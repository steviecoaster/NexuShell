---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# Set-NexusScript

## SYNOPSIS

Updates a script saved in Nexus

## SYNTAX

```powershell
Set-NexusScript [-Name] <String> [-Content] <String> [-Type] <String> [<CommonParameters>]
```

## DESCRIPTION

Updates a script saved in Nexus

## EXAMPLES

### EXAMPLE 1

```powershell
Set-NexusScript -Name SuperAwesomeScript -Content "some awesome groovy code" -Type groovy
```

## PARAMETERS

### -Name

The script to update

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

### -Content

The new content of the script

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

### -Type

The new type, if different

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
