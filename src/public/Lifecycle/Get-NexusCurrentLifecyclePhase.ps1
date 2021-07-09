function Get-NexusCurrentLifecyclePhase {
    <#
    .SYNOPSIS
    Move to new lifecycle phase
    
    .DESCRIPTION
    Move to new lifecycle phase
    
    .EXAMPLE
    Get-NexusCurrentLifecyclePhase

    .EXAMPLE
    Get-NexusLifecycle
    
    .NOTES
    
    #>
    [Alias('Get-NexusLifecycle')]
    [CmdletBinding(HelpUri='')]
    Param()

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        if( -not (Get-NexusLicenseStatus)) {
            throw "Cmdlet requires Nexus Pro"
        }
    }

    process {
        $urislug = '/service/rest/v1/lifecycle/phase'

        Invoke-Nexus -Urislug $urislug -Method GET
    }

}