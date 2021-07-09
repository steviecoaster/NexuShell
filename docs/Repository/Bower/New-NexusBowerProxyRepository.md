---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusBowerProxyRepository

## SYNOPSIS

Creates a new Bower Proxy Repository

## SYNTAX

### Default (Default)

```powershell
New-NexusBowerProxyRepository -Name <String> -ProxyRemoteUrl <String> [-RewritePackageUrls]
 [-ContentMaxAgeMinutes <String>] [-MetadataMaxAgeMinutes <String>] [-UseNegativeCache]
 [-NegativeCacheTTLMinutes <String>] [-CleanupPolicy <String>] [-RoutingRule <String>] [-Online]
 [-BlobStoreName <String>] [-StrictContentValidation] [-DeploymentPolicy <String>] [-UseNexusTrustStore]
 [-BlockOutboundConnections] [-EnableAutoBlocking] [-ConnectionRetries <String>]
 [-ConnectionTimeoutSeconds <String>] [-EnableCircularRedirects] [-EnableCookies] [-CustomUserAgent <String>]
 [<CommonParameters>]
```

### Authentication

```powershell
New-NexusBowerProxyRepository -Name <String> -ProxyRemoteUrl <String> [-RewritePackageUrls]
 [-ContentMaxAgeMinutes <String>] [-MetadataMaxAgeMinutes <String>] [-UseNegativeCache]
 [-NegativeCacheTTLMinutes <String>] [-CleanupPolicy <String>] [-RoutingRule <String>] [-Online]
 [-BlobStoreName <String>] [-StrictContentValidation] [-DeploymentPolicy <String>] [-UseNexusTrustStore]
 [-UseAuthentication] -AuthenticationType <String> -Credential <PSCredential> [-HostnameFqdn <String>]
 [-DomainName <String>] [-BlockOutboundConnections] [-EnableAutoBlocking] [-ConnectionRetries <String>]
 [-ConnectionTimeoutSeconds <String>] [-EnableCircularRedirects] [-EnableCookies] [-CustomUserAgent <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Creates a new Bower Proxy Repository

## EXAMPLES

### EXAMPLE 1

```powershell
$ProxyParameters = @{
    Name = 'BowerProxy'
    ProxyRemoteUrl = 'https://upstream.bowerpkgs.com'
    DeploymentPolicy = 'Allow'
}
```

New-NexusBowerProxyRepository @ProxyParameters

### EXAMPLE 2

```powershell
$ProxyParameters = @{
    Name = 'BowerProxy'
    ProxyRemoteUrl = 'https://upstream.bowerpkgs.com'
    DeploymentPolicy = 'Allow'
    UseAuthentication = $true
    AuthenticationType = 'Username'
    Credential = (Get-Credential)
```

}

New-NexusBowerProxyRepository @ProxyParameters

## PARAMETERS

### -Name

The name to give the repository

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

### -ProxyRemoteUrl

Location of the remote repository being proxied, e.g.
https://api.Bower.org/v3/index.json

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

### -RewritePackageUrls

Whether to force Bower to retrieve packages through this proxy repository

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

### -ContentMaxAgeMinutes

Time before cached content is refreshed.
Defaults to 1440

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

Time before cached metadata is refreshed.
Defaults to 1440

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

### -UseNegativeCache

Use the built-in Negative Cache feature

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

The Negative Cache Time To Live value.
Defaults to 1440

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

### -CleanupPolicy

The Cleanup Policy to apply to this repository

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

Routing Rules you wish to apply to this repository

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

### -BlobStoreName

The back-end blob store in which to store cached packages

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

Validate that all content uploaded to this repository is of a MIME type appropriate for the repository format

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

### -DeploymentPolicy

Controls whether packages can be overwritten

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

### -UseNexusTrustStore

Use certificates stored in the Nexus truststore to connect to external systems

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
