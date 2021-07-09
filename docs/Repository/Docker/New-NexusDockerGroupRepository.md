---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusDockerGroupRepository

## SYNOPSIS

Creates a new Docker Group repository

## SYNTAX

```powershell
New-NexusDockerGroupRepository [-Name] <String> [-GroupMembers] <String[]> [[-WritableMember] <String>]
 [-Online] [[-BlobStoreName] <String>] [-UseStrictContentTypeValidation] [-EnableV1] [-ForceBasicAuth]
 [[-HttpPort] <String>] [[-HttpsPort] <String>] [<CommonParameters>]
```

## DESCRIPTION

Creates a new Docker Group repository

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusDockerGroupRepository -Name DockerGroup -GroupMembers DockerHostedLinux,DockerProd -Online
```

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

### -GroupMembers

{{ Fill GroupMembers Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WritableMember

{{ Fill WritableMember Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlobStoreName

Blob store to use to store Docker packages

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

### -UseStrictContentTypeValidation

{{ Fill UseStrictContentTypeValidation Description }}

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

### -EnableV1

Whether to allow clients to use the V1 API to interact with this repository

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

### -ForceBasicAuth

Whether to force authentication (Docker Bearer Token Realm required if false)

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

### -HttpPort

Create an HTTP connector at specified port

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HttpsPort

Create an HTTPS connector at specified port

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
