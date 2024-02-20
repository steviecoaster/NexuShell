function Start-NexusScript {
    <#
    .SYNOPSIS
    Executes a saved script in Nexus
    
    .DESCRIPTION
    Executes a saved script in Nexus
    
    .PARAMETER Name
    The name of the script to execute
    
    .EXAMPLE
    Start-NexusScript -Name TestScript
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = "/service/rest/v1/script/$Name/run"

        Invoke-Nexus -Urislug $urislug -BodyAsString $Name -ContentType 'text/plain' -Method POST -ErrorAction Stop
    }
}