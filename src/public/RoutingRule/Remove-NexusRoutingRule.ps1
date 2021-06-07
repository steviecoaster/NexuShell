function Remove-NexusRoutingRule {
    <#
    .SYNOPSIS
    Disable realms in Nexus
    
    .DESCRIPTION
    Disable realms in Nexus
    
    .PARAMETER Rule
    The realms you wish to activate

    .PARAMETER Force
    Don't prompt for confirmation
    
    .EXAMPLE
    Remove-NexusRoutingRule -Rule NugetRule

    .EXAMPLE
    Remove-NexusRoutingRule -Rule NugetRule -Force
    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://github.com/steviecoaster/TreasureChest/blob/develop/docs/Remove-NexusRoutingRule.md',SupportsShouldProcess,ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusRoutingRule).name

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                }
                else {
                    $r
                }
            }
        )]
        [Alias('Name')]
        [String[]]
        $Rule,

        [Parameter()]
        [Switch]
        $Force
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/routing-rules/$Rule"

    }

    process {


        try {
           
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$_", "Remove Repository")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                    
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$_", "Remove Repository")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
        }

        catch {
            $_.exception.message
        }

    }
}