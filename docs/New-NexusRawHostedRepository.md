---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusRawHostedRepository

## SYNOPSIS

Creates a new Raw Hosted repository

## SYNTAX

```powershell
New-NexusRawHostedRepository [-Name] <String> [-Online] [[-BlobStore] <String>]
 [-UseStrictContentTypeValidation] [[-DeploymentPolicy] <String>] [[-CleanupPolicy] <String>]
 [-HasProprietaryComponents] [-ContentDisposition] <String> [<CommonParameters>]
```

## DESCRIPTION

Creates a new Raw Hosted repository

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusRawHostedRepository -Name BinaryArtifacts -ContentDisposition Attachment
```

### EXAMPLE 2

```powershell
$RepoParams = @{
    Name = 'BinaryArtifacts'
    Online = $true
    UseStrictContentTypeValidation = $true
    DeploymentPolicy = 'Allow'
    CleanupPolicy = '90Days',
    BlobStore = 'AmazonS3Bucket'
}
```

New-NexusRawHostedRepository @RepoParams

## PARAMETERS

### -Name

The Name of the repository to create

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

### -Online

Mark the repository as Online.
Defaults to True

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlobStore

The blob store to attach the repository too.
Defaults to 'default'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseStrictContentTypeValidation

Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format

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
Position: 3
Default value: Allow_Once
Accept pipeline input: False
Accept wildcard characters: False
```

### -CleanupPolicy

Components that match any of the Applied policies will be deleted

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

### -ContentDisposition

Add Content-Disposition header as 'Attachment' to disable some content from being inline in a browser.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
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
