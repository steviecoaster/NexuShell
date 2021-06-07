---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusAptRepository

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Hosted (Default)
```
New-NexusAptRepository -Name <String> [-Type <String>] [-Distribution <String>] -SigningKey <String>
 [-SigningKeyPassphrase <String>] [-BlobStore <String>] [-StrictContentValidation <String>]
 -DeploymentPolicy <String> [-CleanupPolicy <String>] [-Online <String>] [-HasProprietaryComponents]
 [<CommonParameters>]
```

### Proxy
```
New-NexusAptRepository -Name <String> [-Type <String>] [-Distribution <String>] [-BlobStore <String>]
 [-StrictContentValidation <String>] [-CleanupPolicy <String>] [-Online <String>] [-HasProprietaryComponents]
 -ProxyRemoteUrl <String> [-ContentMaxAgeMinutes <String>] [-MetadataMaxAgeMinutes <String>]
 [-QueryCacheItemMaxAgSeconds <String>] [-UseNegativeCache <String>] [-NegativeCacheTTLMinutes <String>]
 [-FlatUpstream] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -BlobStore
{{ Fill BlobStore Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CleanupPolicy
{{ Fill CleanupPolicy Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentMaxAgeMinutes
{{ Fill ContentMaxAgeMinutes Description }}

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeploymentPolicy
{{ Fill DeploymentPolicy Description }}

```yaml
Type: String
Parameter Sets: Hosted
Aliases:
Accepted values: Allow, Deny, Allow_Once

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Distribution
{{ Fill Distribution Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FlatUpstream
{{ Fill FlatUpstream Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HasProprietaryComponents
{{ Fill HasProprietaryComponents Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MetadataMaxAgeMinutes
{{ Fill MetadataMaxAgeMinutes Description }}

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
{{ Fill Name Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NegativeCacheTTLMinutes
{{ Fill NegativeCacheTTLMinutes Description }}

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Online
{{ Fill Online Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: True, False

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyRemoteUrl
{{ Fill ProxyRemoteUrl Description }}

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryCacheItemMaxAgSeconds
{{ Fill QueryCacheItemMaxAgSeconds Description }}

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SigningKey
{{ Fill SigningKey Description }}

```yaml
Type: String
Parameter Sets: Hosted
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SigningKeyPassphrase
{{ Fill SigningKeyPassphrase Description }}

```yaml
Type: String
Parameter Sets: Hosted
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StrictContentValidation
{{ Fill StrictContentValidation Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: True, False

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
{{ Fill Type Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Hosted, Proxy

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseNegativeCache
{{ Fill UseNegativeCache Description }}

```yaml
Type: String
Parameter Sets: Proxy
Aliases:
Accepted values: True, False

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
