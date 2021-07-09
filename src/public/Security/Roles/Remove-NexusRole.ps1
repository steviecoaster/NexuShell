function Remove-NexusRole {
    <#
    .SYNOPSIS
    Remove a Nexus Role
    
    .DESCRIPTION
    Remove a Nexus Role
    
    .PARAMETER Role
    The role to remove

    .PARAMETER Force
    Don't prompt for confirmation prior to removal
    
    .EXAMPLE
    Remove-NexusRole -Role SampleRole

    .EXAMPLE 
    Remove-NexusRole -Role SampleRole -Force

    .EXAMPLE
    Get-NexusRole -Role SampleRole | Remove-Nexus Role
    
    .NOTES
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Security/Roles/Remove-NexusRole/',SupportsShouldProcess,ConfirmImpact='High')]
    Param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusRole).id

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                } 

                else { 
                    $r
                }
            })]
        [Alias('Id', 'Name')]
        [String[]]
        $Role,

        [Parameter()]
        [Switch]
        $Force
    )

    process {
        $Role | Foreach-Object {
            $urislug = "/service/rest/v1/security/roles/$($_)"

            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Role")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Role")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
        }
    }

}