function Clear-NexusEmailConfig {
    <#
    .SYNOPSIS
    Clears and disables the Smtp configuration in Nexus
    
    .DESCRIPTION
    Clears and disables the Smtp configuration in Nexus
    
    .PARAMETER Force
    Don't prompt before clearing settings
    
    .EXAMPLE
    Clear-NexusEmailConfig

    .EXAMPLE
    Clear-NexusEmailConfig -Force
    
    .NOTES

    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    Param(
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
        $urislug = '/service/rest/v1/email'

        try {
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$Hostname", "Remove SMTP Connection")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                    
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$Hostname", "Remove SMTP Connection")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
        }

        catch {
            $_.exception.message
        }
    }
}