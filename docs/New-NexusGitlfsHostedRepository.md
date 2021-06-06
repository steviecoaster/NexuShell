---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusGitlfsHostedRepository

## SYNOPSIS

Creates a new GitLfs Hosted repository

## SYNTAX

```powershell
New-NexusGitlfsHostedRepository [-Name] <String> [[-CleanupPolicy] <String>] [-Online]
 [[-BlobStoreName] <String>] [-UseStrictContentValidation] [[-DeploymentPolicy] <String>]
 [-HasProprietaryComponents] [<CommonParameters>]
```

## DESCRIPTION

Creates a new GitLfs Hosted repository

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusGitLfsHostedRepository -Name GitLfsHostedTest -DeploymentPolicy Allow
```

### EXAMPLE 2

```powershell
$RepoParams = @{
    Name = 'MyGitLfsRepo'
    CleanupPolicy = '90 Days'
    DeploymentPolicy = 'Allow'
    UseStrictContentValidation = $true
}
```

New-NexusGitLfsHostedRepository @RepoParams

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

Blob store to use to store GitLfs packages

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

### -UseStrictContentValidation

{{ Fill UseStrictContentValidation Description }}

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

### -DeploymentPolicy

Controls if deployments of and updates to artifacts are allowed

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
