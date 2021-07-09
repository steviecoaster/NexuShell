---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusNugetComponent

## SYNOPSIS

Uploads a NuGet package to Nexus through the Components API

## SYNTAX

```powershell
New-NexusNugetComponent [-RepositoryName] <String> [-NuGetComponent] <String> [<CommonParameters>]
```

## DESCRIPTION

Uploads a nuget package to Nexus through the Components API

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusNugetComponent -RepositoryName ProdNuGet -NuGetComponent C:\temp\awesomepackage.0.1.0.nupkg
```

## PARAMETERS

### -RepositoryName

The repository to upload too

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

### -NuGetComponent

The nuget package to upload

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
