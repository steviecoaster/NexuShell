function Get-NexusLicenseStatus {
    <#
    .SYNOPSIS
    Gets license information from a Nexus instance, if available
    
    .DESCRIPTION
    Gets license information from a Nexus instance, if available
    
    .EXAMPLE
    Get-NexusLicenseStatus
    #>
    [CmdletBinding(HelpUri='https://github.com/steviecoaster/TreasureChest/blob/develop/docs/Get-NexusLicenseStatus.md')]
    Param()
    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/system/license"
    }

    process {
        try {
            Invoke-Nexus -UriSlug $urislug -Method 'GET' -ErrorAction Stop
        }

        catch {

            Write-Warning "Nexus license not found, running in OSS mode"
        }
    }
}