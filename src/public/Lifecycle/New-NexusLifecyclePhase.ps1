function New-NexusLifecyclePhase {
    <#
    .SYNOPSIS
    Move to new lifecycle phase
    
    .DESCRIPTION
    Move to new lifecycle phase
    
    .PARAMETER Phase
    The phase to move to
    
    .EXAMPLE
    New-NexusLifecyclePhase -Phase NextPhase
    
    .NOTES

    #>
    [Alias('New-NexusLifecycle')]
    [CmdletBinding(HelpUri='')]
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
        $urislug = '/service/rest/v1/lifecycle'
        Invoke-Nexus -Urislug $urislug -BodyAsString $Phase -Method PUT
    }
}