function Remove-NexusContentSelector {
    <#
    .SYNOPSIS
    Removes a Nexus Content Selector
    
    .DESCRIPTION
    Removes a Nexus Content Selector
    
    .PARAMETER Name
    The Content Selector to remove

    .PARAMETER Force
    Don't prompt for confirmation before removing
    
    .EXAMPLE
    Remove-NexusContentSelector -Name MavenContent

    .EXAMPLE
    Remove-NexusContentSelect -Name MavenContent -Force

    .EXAMPLE
    Get-NexusContentSelector | Remove-NexusContentSelector -Force
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/Security/Content%20Selectors/Remove-NexusContentSelector/',SupportsShouldProcess,ConfirmImpact='High')]
    Param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusContentSelector).Name

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                }
                else {
                    $r
                }
            })]
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

            $urislug = "/service/rest/v1/security/content-selectors/$_"
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Content Selector")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$($_)", "Remove Content Selector")) {
                    Invoke-Nexus -UriSlug $urislug -Method DELETE -ErrorAction Stop
                }
            }
        }
    }
}