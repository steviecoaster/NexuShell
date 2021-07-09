---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# Get-NexusAsset

## SYNOPSIS

Retrieve asset information from Nexus

## SYNTAX

### repo (Default)

```powershell
Get-NexusAsset -RepositoryName <String> [<CommonParameters>]
```

### Id

```powershell
Get-NexusAsset -Id <String> [<CommonParameters>]
```

## DESCRIPTION

Retrieve asset informatino from Nexus

## EXAMPLES

### EXAMPLE 1

```
Get-NexusAsset -RepositoryName Dev
```

### EXAMPLE 2

```
Get-NexusAsset -Id RGV2OmM2MGJjNmI5NjEyZjQ3ZDM5ZTc2ZmMwNTI1ODg0M2Rj
```

## PARAMETERS

### -RepositoryName

The repository to query for assets

```yaml
Type: String
Parameter Sets: repo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

A specific asset to retrieve

```yaml
Type: String
Parameter Sets: Id
Aliases:

Required: True
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
