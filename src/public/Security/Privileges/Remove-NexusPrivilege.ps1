function Remove-NexusPrivilege {
    <#
    .SYNOPSIS
    Remove a Nexus Privilege
    
    .DESCRIPTION
    Remove a Nexus Privilege
    
    .PARAMETER PrivilegeId
    The id of the privilege to delete.

    .PARAMETER Force
    Don't prompt for confirmation before removal
    
    .EXAMPLE
    Remove-NexusPrivilege -PrivilegeId NuGetSuperAdmin

    .EXAMPLE
    Get-NexusPrivilege -PrivilegeId NuGetSuperAdmin | Remove-NexusPrivilege

    .EXAMPLE
    Remove-NexusPrivilege -PrivilegeId NuGetSuperAdmin -Force
    
    .NOTES
    General notes
    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/Security/Privileges/Remove-NexusPrivilege/',SupportsShouldProcess,ConfirmImpact="High")]
    Param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [ArgumentCompleter({
            param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

            $r = (Get-NexusPrivilege).Name

            if($WordToComplete){
                $r.Where($_ -match "^$WordToComplete")
            }
            else {
                $r
            }
        })]
        [String[]]
        [Alias('Name')]
        $PrivilegeId,

        [Parameter()]
        [Switch]
        $Force
    )

    process {
        $PrivilegeId | Foreach-Object {
            $urislug = "/service/rest/v1/security/privileges/$($_)"

            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Privilege")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Privilege")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
        }
    }
}