function Remove-NexusScript {
    <#
    .SYNOPSIS
    Deletes a stored script from Nexus
    
    .DESCRIPTION
    Deletes a stored script from Nexus
    
    .PARAMETER Name
    The script to remove
    
    .PARAMETER Force
    Don't prompt for confirmation before removing
    
    .EXAMPLE
    Remove-NexusScript -Name TestScript

    .EXAMPLE
    Remove-NexusScript -Name TestScript -Force

    .EXAMPLE
    GetNexusScript | Remove-NexusScript -Force
    
    .NOTES

    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusScript).name

                if ($WordToComplete) {
                    $r.Where{ $_ -match "^$WordToComplete" }
                }
                else {
                    $r
                }
            }
        )]
        [String[]]
        $Name,

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
       
        $Name | Foreach-Object {

            $urislug = "/service/rest/v1/script/$_"

            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$_", "Remove Script")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$_", "Remove Script")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }

        } 
    }
}