function Install-NexusLicense {
    <#
    .SYNOPSIS
    Installs a license on a nexus instance.
    
    .DESCRIPTION
    Installs a license on a nexus instance.
    
    .PARAMETER NexusLicense
    The license file to install
    
    .EXAMPLE
    Install-NexusLicense -NexusLicense 'C:\temp\sonatype-repository-manager.lic'
    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/Install-NexusLicense/')]
    Param(
        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path $_})]
        [String]
        $NexusLicense
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/system/license"
    }

    process {
        $file = Get-Item $NexusLicense

        Invoke-Nexus -UriSlug $urislug -Method 'POST' -Body $file -ContentType 'application/octetstream'
    }
}