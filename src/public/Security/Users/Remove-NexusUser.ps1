function Remove-NexusUser {
    <#
    .SYNOPSIS
    Delete a  Nexus user.
    
    .DESCRIPTION
    Delete a Nexus user.
    
    .PARAMETER Username
    The userid the request should apply to.
    
    .PARAMETER Force
    Don't prompt for confirmation before deleting
    
    .EXAMPLE
    Remove-NexusUser -Username jimmy

    .EXAMPLE
    Remove-NexusUser -Username jimmy -Force

    .EXAMPLE
    Get-NexusUser -User jimmy | Remove-NexusUser -Force
    
    .NOTES
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Security/User/Remove-NexusUser/',SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias('userId')]
        [String[]]
        $Username,

        [Parameter()]
        [Switch]
        $Force
    )

    process {

        $Username | Foreach-Object {
            $urislug = "/service/rest/v1/security/users/$_"
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove User")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove User")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE
                }
            }
        }
    }
}