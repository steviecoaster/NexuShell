function Remove-NexusComponent {
    <#
    .SYNOPSIS
    Removes a component from a Nexus Repository

    .DESCRIPTION
    Removes a component from a Nexus Repository

    .PARAMETER Id
    The ID of the component to remove

    .EXAMPLE
    Remove-NexusComponent -Id RGV2OmM2MGJjNmI5NjEyZjQ3ZDM5ZTc2ZmMwNTI1ODg0M2Rj

    .EXAMPLE
    Get-NexusComponent -Repository dev | Where-Object {$_.Name -eq "somePackage" -and $_.Version "1.2.3"} | Remove-NexusComponent -Confirm:$false
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Assets/Remove-NexusComponent/', SupportsShouldProcess, ConfirmImpact='High')]
    Param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [String[]]
        $Id
    )
    process {
        $Id | ForEach-Object {
            $urislug = "/service/rest/v1/components/$($_)"

            if ($PSCmdlet.ShouldProcess("$($_)", "Remove Component")) {
                $null = Invoke-Nexus -UriSlug $urislug -Method DELETE
            }
        }
    }
}