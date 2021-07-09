---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusBowerHostedRepository

## SYNOPSIS

Creates a new Bower Hosted repository

## SYNTAX

```powershell
New-NexusBowerHostedRepository [-Name] <String> [[-CleanupPolicy] <String>] [[-Online] <String>]
 [[-BlobStoreName] <String>] [[-UseStrictContentValidation] <String>] [[-DeploymentPolicy] <String>]
 [-HasProprietaryComponents] [<CommonParameters>]
```

## DESCRIPTION

Creates a new Bower Hosted repository

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusBowerHostedRepository -Name BowerHostedTest -DeploymentPolicy Allow
```

### EXAMPLE 2

```powershell
$RepoParams = @{
    Name = MyBowerRepo
    CleanupPolicy = '90 Days'
    DeploymentPolicy = 'Allow'
    UseStrictContentValidation = $true
}
```

New-NexusBowerHostedRepository @RepoParams

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

### -CleanupPolicy

The Cleanup Policies to apply to the repository

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

### -Online

Marks the repository to accept incoming requests

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlobStoreName

Blob store to use to store Bower packages

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseStrictContentValidation

{{ Fill UseStrictContentValidation Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeploymentPolicy

Controls if deployments of and updates to artifacts are allowed

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

### -HasProprietaryComponents

Components in this repository count as proprietary for namespace conflict attacks (requires Sonatype Nexus Firewall)

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
