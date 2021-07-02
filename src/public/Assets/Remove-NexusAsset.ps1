function Remove-NexusAsset {
    <#
    .SYNOPSIS
    Removes an asset from a Nexus Repository
    
    .DESCRIPTION
    Removes an asset from a Nexus Repository
    
    .PARAMETER Id
    The id of the asset for removal
    
    .PARAMETER Force
    Don't prompt for confirmation before deleting
    
    .EXAMPLE
    Remove-NexusAsset -Id RGV2OmM2MGJjNmI5NjEyZjQ3ZDM5ZTc2ZmMwNTI1ODg0M2Rj

    .EXAMPLE
    Remove-NexusAsset -Id RGV2OmM2MGJjNmI5NjEyZjQ3ZDM5ZTc2ZmMwNTI1ODg0M2Rj -Force
    
    .NOTES
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Assets/Remove-NexusAsset/',SupportsShouldProcess,ConfirmImpact='High')]
    Param(
        [Parameter(Mandatory)]
        [String[]]
        $Id,

        [Parameter()]
        [Switch]
        $Force
    )

    process {
        $Id | Foreach-Object {
            $urislug = "/service/rest/v1/assets/$($_)"
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Asset")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Asset")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE
                }
            }
        }    
    }
}