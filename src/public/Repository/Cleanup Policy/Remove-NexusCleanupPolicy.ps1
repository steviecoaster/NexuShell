function Remove-NexusCleanupPolicy {
    <#
    .SYNOPSIS
    Removes a Nexus Cleanup Policy
    
    .DESCRIPTION
    Removes a Nexus Cleanup Policy
    
    .PARAMETER Name
    The policy to remove
    
    .PARAMETER Force
    Don't prompt for confirmation before removal
    
    .EXAMPLE
    Remove-NexusCleanupPolicy -Name TestPolicy

    .EXAMPLE
    Remove-NexusCleanupPolicy -Name TestPolicy -Force

    .EXAMPLE
    Get-NexusCleanupPolicy -Name TestPol | Remove-NexusCleanupPolicy -Force
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Repository/Cleanup%20Policy/Remove-NexusCleanupPolicy/',SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ArgumentCompleter( {
                param($Command, $Parameters, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusCleanupPolicy).Name

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                } 

                else {
                    $r
                }
            })]
        [String]
        $Name,

        [Parameter()]
        [Switch]
        $Force
    )

    process {

        $Name | Foreach-Object {
            $urislug = "/service/rest/internal/cleanup-policies/$($_)?_dc=$(([DateTime]::ParseExact("01/02/0001 21=08=29", "MM/dd/yyyy HH=mm=ss",$null)).Ticks)"
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Cleanup Policy")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Cleanup Policy")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE
                }
            }
        }    }
}