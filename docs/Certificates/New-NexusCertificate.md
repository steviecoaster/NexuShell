---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusCertificate

## SYNOPSIS

Add a certificate to the trust store.

## SYNTAX

```powershell
New-NexusCertificate [-PemFile] <String> [<CommonParameters>]
```

## DESCRIPTION

Add a certificate to the trust store.

## EXAMPLES

### EXAMPLE 1

```powershell
New-NexusCertificate -PemFile C:\cert\prod.pem
```

## PARAMETERS

### -PemFile

The certificate to add encoded in PEM format

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
