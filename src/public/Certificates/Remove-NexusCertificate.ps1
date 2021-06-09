function Remove-NexusCertificate {
    <#
    .SYNOPSIS
    Remove a certificate in the trust store.
    
    .DESCRIPTION
    Remove a certificate in the trust store.
    
    .PARAMETER Thumbprint
    The id of the certificate that should be removed.
    
    .PARAMETER Force
    Don't prompt before removing
    
    .EXAMPLE
    Remove-NexusCertificate -Thumbprint 1a:25:25:25:93:85:94
    
    .EXAMPLE
    Remove-NexusCertificate -Thumbprint 1a:25:25:25:93:85:94 -Force

    .EXAMPLE
    Get-NexusCertificate | Remove-NexusCertificate
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Remove-NexusCertificate/',SupportsShouldProcess,ConfirmImpact='High')]
    Param(
        [Alias('Id')]
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [String]
        $Thumbprint,

        [Parameter()]
        [Switch]
        $Force
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = "/service/rest/v1/security/ssl/truststore/$Thumbprint"
        if ($Force -and -not $Confirm) {
            $ConfirmPreference = 'None'
            if ($PSCmdlet.ShouldProcess("$Thumbprint", "Remove certificate")) {
                Invoke-Nexus -UriSlug $urislug -Method DELETE
            }
        }
        else {
            if ($PSCmdlet.ShouldProcess("$Thumbprint", "Remove certificate")) {
                Invoke-Nexus -UriSlug $urislug -Method DELETE
            }
        }
}
}