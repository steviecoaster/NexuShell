function Get-NexusCertificate {
    <#
    .SYNOPSIS
    Retrieve a list of certificates added to the trust store
    
    .DESCRIPTION
    Retrieve a list of certificates added to the trust store
    
    .EXAMPLE
    Get-Nexuscertificate
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Get-NexusCertificate/')]
    Param()

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = '/service/rest/v1/security/ssl/truststore'
        $result = Invoke-Nexus -Urislug $urislug -Method GET

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