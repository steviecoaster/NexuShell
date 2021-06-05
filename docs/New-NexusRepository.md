---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# New-NexusRepository

## SYNOPSIS
Creates a new repository in your Nexus server

## SYNTAX

### Proxy
```
New-NexusRepository -Name <String> -Format <String> -Type <String> -ProxyRemoteUrl <String>
 [-ContentMaxAgeMinutes <String>] [-MetadataMaxAgeMinutes <String>] [-QueryCacheItemMaxAgSeconds <String>]
 [-NugetVersion <String>] [-UseNegativeCache <String>] [-NegativeCacheTTLMinutes <String>]
 [-CleanupPolicy <String>] [-RoutingRule <String>] [-Online <String>] [-BlobStoreName <String>]
 [-StrictContentValidation <String>] [-DeploymentPolicy <String>] [<CommonParameters>]
```

### Hosted
```
New-NexusRepository -Name <String> -Format <String> -Type <String> [-CleanupPolicy <String>]
 [-RoutingRule <String>] [-Online <String>] [-BlobStoreName <String>] [-StrictContentValidation <String>]
 [-DeploymentPolicy <String>] [<CommonParameters>]
```

### Group
```
New-NexusRepository -Name <String> -Format <String> -Type <String> -GroupMember <String[]>
 [-CleanupPolicy <String>] [-RoutingRule <String>] [-Online <String>] [-BlobStoreName <String>]
 [-StrictContentValidation <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new repository of the specified type and settings in your Nexus server

## EXAMPLES

### EXAMPLE 1
```
New-NexusRepository -Name NugetCenter -Format nuget -Type hosted -DeploymentPolicy Allow
```

### EXAMPLE 2
```
New-NexusRepository -Name ChocoUpstream -Format nuget -Type proxy -ProxyRemoteUrl 'https://chocolatey.org/api/v2'
```

## PARAMETERS

### -Name
The name to give to the new repository

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

### -Format
The format of the new repository

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

### -Type
The type of repository to create: Hosted,Group,Proxy

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

### -GroupMember
Members to add to group repository types.
Must be of the same repository format as the repository you are creating

```yaml
Type: String[]
Parameter Sets: Group
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyRemoteUrl
When setting a Proxy type repository, this is the upstream repository url to point the new repository

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

### -ContentMaxAgeMinutes
When using a Proxy type repository, the length of time to cache package contents before reaching back out to the upstream url

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: 1440
Accept pipeline input: False
Accept wildcard characters: False
```

### -MetadataMaxAgeMinutes
When using a Proxy type repository, the length of time to cache package metadata before reaching back out to the upstream url

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: 1440
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryCacheItemMaxAgSeconds
When using a Proxy type repository, the length of time to cache upstream url repsonses

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: 3600
Accept pipeline input: False
Accept wildcard characters: False
```

### -NugetVersion
For Nuget proxy repositories the version of nuget packages your upstream url contains

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: V3
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseNegativeCache
Use Negative Cache for proxy url

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -NegativeCacheTTLMinutes
The Negative Cache TTL value

```yaml
Type: String
Parameter Sets: Proxy
Aliases:

Required: False
Position: Named
Default value: 1440
Accept pipeline input: False
Accept wildcard characters: False
```

### -CleanupPolicy
The cleanup policy to apply to the new repository

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

### -RoutingRule
The Routing Rule to apply to the new repository

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

### -Online
Make the new repository immediately available for use.
This basically means "Enabled", or "Disabled"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlobStoreName
The blob store to use with the new repository

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -StrictContentValidation
Specify that uploaded artifacts adhere to the MIME type of the specified format

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeploymentPolicy
Controls whether you can push the same package version repeatedly, or push packages at all

```yaml
Type: String
Parameter Sets: Proxy, Hosted
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

## RELATED LINKS
