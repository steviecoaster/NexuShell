function Restart-NexusLifecyclePhase {
    <#
    .SYNOPSIS
    Re-runs all phases from the given phase to the current phase
    
    .DESCRIPTION
    Re-runs all phases from the given phase to the current phase
    
    .PARAMETER Phase
    The phase to bounce
    
    .EXAMPLE
    Restart-NexusLifecyclePhase -Phase 'SomePreviousPhase'
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Phase
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        if( -not (Get-NexusLicenseStatus)) {
            throw "Cmdlet requires Nexus Pro"
        }
    }

    process {
        $urislug = '/service/rest/v1/lifecycle/bounce'
        Invoke-Nexus -Urislug $urislug -BodyAsString $Phase -Method PUT
    }
}