---
external help file: TreasureChest-help.xml
Module Name: TreasureChest
online version:
schema: 2.0.0
---

# Set-NexusEmailconfig

## SYNOPSIS

Sets the email settings for Nexus

## SYNTAX

```powershell
Set-NexusEmailconfig [[-SmtpServer] <String>] [-SmtpPort] <Int32> [-Enabled] [[-Credential] <PSCredential>]
 [[-FromAddress] <String>] [[-SubjectPrefix] <String>] [-StartTlsEnabled] [-StartTlsRequired] [-SSLOnConnect]
 [-VerifyServerIdentity] [-UseNexusTrustStore] [<CommonParameters>]
```

## DESCRIPTION

Sets the email settings for Nexus

## EXAMPLES

### EXAMPLE 1

```powershell
Set-NexusEmailConfig -SmtpSerer mail.foo.org -Port 25 -Enabled
```

### EXAMPLE 2

```powershell
Set-NexusEmailConfig -SmtpServer mail.foo.org -Port 427 -Enabled -StartTlsEnabled -StartTlsrequired
```

## PARAMETERS

### -SmtpServer

The hostname or IP address of your mail server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SmtpPort

The SMTP port of your mail server

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Enabled

Enable sending mail from Nexus

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

### -Credential

Credentials to connect to your SMTP server if required

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FromAddress

Messages from Nexus with be sent from this email address

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

### -SubjectPrefix

Append a prefix to messages from Nexus if desired

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

### -StartTlsEnabled

Enable StartTLS

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

### -StartTlsRequired

Require TLS on the smtp connection

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

### -SSLOnConnect

Require SSL on the smtp connection

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

### -VerifyServerIdentity

Verify mail server identity before sending messages

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

### -UseNexusTrustStore

Use Nexus Trust Store for email certificates

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
