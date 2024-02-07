function Remove-NexusLicense {
    <#
    .SYNOPSIS
    Removes the license from a Nexus instance
    
    .DESCRIPTION
    Removes the license from a Nexus instance

    .PARAMETER Force
    Don't prompt for confirmation before removing the license
    
    .EXAMPLE
    Remove-NexusLicense
    
    .EXAMPLE
    Remove-NexusLicense -Force
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Remove-NexusLicense/',SupportsShouldProcess,ConfirmImpact='High')]
    Param(
        [Parameter()]
        [Switch]
        $Force
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/system/license"
    }


    process {

        try {
           
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$Hostname", "Remove Nexus license")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                    Write-Warning "License has been removed. Nexus service restart necessary"
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$Hostname", "Remove Nexus license")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                    Write-Warning "License has been removed. Nexus service restart necessary"
                }
            }
        }

        catch {
            $_.exception.message
        }
    }
}