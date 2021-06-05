---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusAptHostedRepository

## SYNOPSIS

Creates a new Hosted Apt repository

## SYNTAX

```powershell
New-NexusAptHostedRepository [-Name] <String> [-Distribution] <String> [-SigningKey] <String>
 [[-SigningKeyPassphrase] <String>] [[-BlobStore] <String>] [-StrictContentValidation]
 [-DeploymentPolicy] <String> [[-CleanupPolicy] <String>] [-Online] [-HasProprietaryComponents]
 [<CommonParameters>]
```

## DESCRIPTION

Creates a new Hosted Apt repository

## EXAMPLES

### EXAMPLE 1

```powershell
$RepoParams = @{
    Name = 'AptPackages'
    Distribution = 'bionic'
    SigningKey = 'SuperSecretString'
    DeploymentPolicy = 'Allow_Once'
}
```

New-NexusAptHostedRepository @RepoParams

## PARAMETERS

### -Name

The name given to the repository

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

### -Distribution

Distribution to fetch e.g.
bionic

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

### -SigningKey

PGP signing key pair (armored private key e.g.
gpg --export-secret-key --armor )

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

### -SigningKeyPassphrase

Passphrase to access PGP Signing Key

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

### -BlobStore

Blob store used to store repository contents

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -StrictContentValidation

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

Required: True
Position: 6
Default value: None
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
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Online

The repository accepts incoming requests

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
