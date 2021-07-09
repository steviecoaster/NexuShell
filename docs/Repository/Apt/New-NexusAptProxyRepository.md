---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusAptProxyRepository

## SYNOPSIS

Creates a new Apt Proxy Repository

## SYNTAX

### Hosted (Default)

```powershell
New-NexusAptProxyRepository -Name <String> -Distribution <String> -SigningKey <String>
 [-SigningKeyPassphrase <String>] [-BlobStore <String>] [-StrictContentValidation] -DeploymentPolicy <String>
 [-CleanupPolicy <String>] [-Online] [-HasProprietaryComponents] -ProxyRemoteUrl <String>
 [-ContentMaxAgeMinutes <String>] [-MetadataMaxAgeMinutes <String>] [-QueryCacheItemMaxAgSeconds <String>]
 [-UseNegativeCache] [-NegativeCacheTTLMinutes <String>] [-FlatUpstream] [-BlockOutboundConnections]
 [-EnableAutoBlocking] [-ConnectionRetries <String>] [-ConnectionTimeoutSeconds <String>]
 [-EnableCircularRedirects] [-EnableCookies] [-CustomUserAgent <String>] [<CommonParameters>]
```

### Authentication

```powershell
New-NexusAptProxyRepository -Name <String> -Distribution <String> -SigningKey <String>
 [-SigningKeyPassphrase <String>] [-BlobStore <String>] [-StrictContentValidation] -DeploymentPolicy <String>
 [-CleanupPolicy <String>] [-Online] [-HasProprietaryComponents] -ProxyRemoteUrl <String>
 [-ContentMaxAgeMinutes <String>] [-MetadataMaxAgeMinutes <String>] [-QueryCacheItemMaxAgSeconds <String>]
 [-UseNegativeCache] [-NegativeCacheTTLMinutes <String>] [-FlatUpstream] [-UseAuthentication]
 -AuthenticationType <String> -Credential <PSCredential> [-HostnameFqdn <String>] [-DomainName <String>]
 [-BlockOutboundConnections] [-EnableAutoBlocking] [-ConnectionRetries <String>]
 [-ConnectionTimeoutSeconds <String>] [-EnableCircularRedirects] [-EnableCookies] [-CustomUserAgent <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Creates a new Apt Proxy Repository

## EXAMPLES

### EXAMPLE 1

```powershell
$RepoParams = @{
    Name = 'AptProxy'
    Distribution = 'bionic'
    SigningKey = 'SuperSecretKey'
    DeploymentPolicy = 'Allow_Once'
    ProxyUrl = 'https://upstream.deb.com'
}
```

New-NexusAptProxyRepository @RepoParams

## PARAMETERS

### -Name

The name given to the repository

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

### -Distribution

Distribution to fetch e.g.
bionic

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

### -SigningKey

PGP signing key pair (armored private key e.g.
gpg --export-secret-key --armor )

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

### -SigningKeyPassphrase

Passphrase to access PGP Signing Key

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

### -BlobStore

Blob store used to store repository contents

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

### -UseStrictContentValidation

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
Position: Named
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
Position: Named
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

### -ProxyRemoteUrl

Location of the remote repository being proxied

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

### -ContentMaxAgeMinutes

How long (in minutes) to cache artifacts before rechecking the remote repository.
Release repositories should use -1.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1440
Accept pipeline input: False
Accept wildcard characters: False
```

### -MetadataMaxAgeMinutes

How long (in minutes) to cache metadata before rechecking the remote repository.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1440
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryCacheItemMaxAgSeconds

How long to cache the fact that a file was not found in the repository (in minutes)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 3600
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseNegativeCache

Cache responses for content not present in the proxied repository

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

### -NegativeCacheTTLMinutes

How long to cache the fact that a file was not found in the repository (in minutes)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1440
Accept pipeline input: False
Accept wildcard characters: False
```

### -FlatUpstream

Is this repository flat?

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

### -UseAuthentication

Use authentication for the upstream repository

```yaml
Type: SwitchParameter
Parameter Sets: Authentication
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthenticationType

The type of authentication required by the upstream repository

```yaml
Type: String
Parameter Sets: Authentication
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Credentials to use to connecto to upstream repository

```yaml
Type: PSCredential
Parameter Sets: Authentication
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostnameFqdn

If using NTLM authentication, the Hostname of the NTLM host to query

```yaml
Type: String
Parameter Sets: Authentication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainName

The domain name of the NTLM host

```yaml
Type: String
Parameter Sets: Authentication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlockOutboundConnections

Block outbound connections on the repository

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

### -EnableAutoBlocking

Auto-block outbound connections on the repository if remote peer is detected as unreachable/unresponsive

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

### -ConnectionRetries

Connection attempts to upstream repository before a failure

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

### -ConnectionTimeoutSeconds

Amount of time to wait before retrying the connection to the upstream repository

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

### -EnableCircularRedirects

Enable redirects to the same location (may be required by some servers)

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

### -EnableCookies

Allow cookies to be stored and used

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

### -CustomUserAgent

Custom fragment to append to "User-Agent" header in HTTP requests

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
