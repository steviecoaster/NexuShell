function New-NexusCertificate {
    <#
    .SYNOPSIS
    Add a certificate to the trust store.
    
    .DESCRIPTION
    Add a certificate to the trust store.
    
    .PARAMETER PemFile
    The certificate to add encoded in PEM format
    
    .EXAMPLE
    New-NexusCertificate -PemFile C:\cert\prod.pem
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ValidateScript({ 
            Test-Path $_ 
        })]
        [String]
        $PemFile
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = '/service/rest/v1/security/ssl/truststore'
        $Cert = Get-Content $PemFile -Raw
        $result = Invoke-Nexus -Urislug $urislug -BodyAsString $Cert -Method POST

        $result | Foreach-Object {
            [pscustomobject]@{
                ExpiresOn = $_.expiresOn
                Fingerprint = $_.fingerprint
                Id = $_.id
                IssuedOn = $_.issuedOn
                IssuerCommonName = $_.issuerCommonName
                IssuerOrganization = $_.issuerOrganization
                IssuerOrganizationalUnit = $_.issueOrganizationalUnit
                Pem = $_.pem
                SerialNumber = $_.serialNumber
                SubjectCommonName = $_.subjectCommonName
                SubjectOrganization = $_.subjectOrganization
                SubjectOrganizationalUnit = $_.subjectOrganizationalUnit
            }
        }

    }
}