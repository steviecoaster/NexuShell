---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusBlobStore

## SYNOPSIS
Creates a new blob store

## SYNTAX

### S3
```
New-NexusBlobStore -Type <String> -Name <String> [<CommonParameters>]
```

### File
```
New-NexusBlobStore -Type <String> -Name <String> [-UseQuota] [-QuotaType <String>] [-SoftQuotaInMB <Int32>]
 [-Path <String>] [<CommonParameters>]
```

### FileQuota
```
New-NexusBlobStore [-UseQuota] -QuotaType <String> -SoftQuotaInMB <Int32> [<CommonParameters>]
```

### S3Options
```
New-NexusBlobStore -Bucket <String> [-Region <String>] [-Prefix <String>] [-ExpirationDays <Int32>]
 [<CommonParameters>]
```

### S3AuthenticationSettings
```
New-NexusBlobStore [-UseAuthentication] -AccessKey <String> -SecretKey <String> [-AssumeRoleARN <String>]
 [-SessionTokenARN <String>] [<CommonParameters>]
```

### S3EncryptionSettings
```
New-NexusBlobStore [-UseEncryption] -EncryptionType <String> [-KMSKeyId <String>] [<CommonParameters>]
```

## DESCRIPTION
Nexus stores artifacts for repositories in blobs.
This cmdlet creates a new Nexus Blob for your artifacts

## EXAMPLES

### EXAMPLE 1
```
New-NexusBlobStore -Name TreasureBlobQuota -Type File -Path C:\blob2 -UseQuota -QuotaType spaceRemainingQuota -SoftQuotaInMB 300
```

### EXAMPLE 2
```
New-NexusBlobStore -Name TreasureBlob -Type File -Path C:\blob
```

## PARAMETERS

### -Type
The type of Blob Store to create.
This can be File, or S3

```yaml
Type: String
Parameter Sets: S3, File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the blob store

```yaml
Type: String
Parameter Sets: S3, File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseQuota
Enforce a Quota on the blob

```yaml
Type: SwitchParameter
Parameter Sets: File
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: SwitchParameter
Parameter Sets: FileQuota
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuotaType
The type of Quota to enforce

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: FileQuota
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SoftQuotaInMB
The storage limit for the Quota

```yaml
Type: Int32
Parameter Sets: File
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32
Parameter Sets: FileQuota
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path for the File type blob

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Bucket
The bucket for the S3 type blob

```yaml
Type: String
Parameter Sets: S3Options
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Region
The AWS region of the S3 bucket

```yaml
Type: String
Parameter Sets: S3Options
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prefix
(Optional) Prefix of S3 bucket

```yaml
Type: String
Parameter Sets: S3Options
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpirationDays
The amount of time to wait after removing an S3 blob store for the underlying bucket to be deleted

```yaml
Type: Int32
Parameter Sets: S3Options
Aliases:

Required: False
Position: Named
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseAuthentication
Require authentication for an S3 blob

```yaml
Type: SwitchParameter
Parameter Sets: S3AuthenticationSettings
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessKey
The access key needed to connect an S3 blob when using authentication

```yaml
Type: String
Parameter Sets: S3AuthenticationSettings
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretKey
The Secret Key needed to connect an S3 blob when using authentication

```yaml
Type: String
Parameter Sets: S3AuthenticationSettings
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssumeRoleARN
Optional AssumeRoleARN for s3 blob authentication

```yaml
Type: String
Parameter Sets: S3AuthenticationSettings
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionTokenARN
Optional SessionTokenARN for s3 blob authentication

```yaml
Type: String
Parameter Sets: S3AuthenticationSettings
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseEncryption
Require encryption of the S3 blob

```yaml
Type: SwitchParameter
Parameter Sets: S3EncryptionSettings
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EncryptionType
The type of encryption to use

```yaml
Type: String
Parameter Sets: S3EncryptionSettings
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KMSKeyId
If using KMS Encryption the KMS Key Id needed

```yaml
Type: String
Parameter Sets: S3EncryptionSettings
Aliases:

Required: False
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
S3 buckets are currently not supported by the cmdlet until I can get S3 for testing

## RELATED LINKS
