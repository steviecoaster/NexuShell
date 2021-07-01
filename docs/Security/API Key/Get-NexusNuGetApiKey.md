---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Get-NexusNuGetApiKey

## SYNOPSIS

Retrieves the NuGet API key of the given user credential

## SYNTAX

```powershell
Get-NexusNuGetApiKey [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION

Retrieves the NuGet API key of the given user credential

## EXAMPLES

### EXAMPLE 1

```powershell
Get-NexusNugetApiKey -Credential (Get-Credential)
```

## PARAMETERS

### -Credential

The Nexus User whose API key you wish to retrieve

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
