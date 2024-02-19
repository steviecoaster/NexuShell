function Remove-NexusTag {
    <#
    .SYNOPSIS
    Removes a tag from Sonatype Nexus
    
    .DESCRIPTION
    Removes a tag from Nexus. Completely disassociates all tagged components. Use Remove-NexusTagAssociation to modify tags on individual components.
    
    .PARAMETER Tag
    The tag to remove
    
    .PARAMETER Force
    Don't prompt for confirmation.
    
    .EXAMPLE
    Remove-NexusTag -Tag SampleTag

    This will prompt you to confirm the deletion

    .EXAMPLE
    Remove-NexusTag -Tag SampleTag -Force

    No prompts for confirmation. Potentially dangerous. Use -Whatif if not sure of results

    .LINK
    https://help.sonatype.com/en/tagging.html
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High', HelpUri = 'https://steviecoaster.github.io/NexuShell/Tags/Remove-NexusTag/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Tag,

        [Parameter()]
        [Switch]
        $Force
    )
    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
        
        $urislug = '/service/rest/v1/tags/{0}' -f $Tag
    }
    process {
        if ($Force -and -not $Confirm) {
            $ConfirmPreference = 'None'
            if ($PSCmdlet.ShouldProcess("$($_)", "Remove Tag")) {
                Invoke-Nexus -Urislug $urislug -Method 'DELETE'
            }
        }
        else {
            if ($PSCmdlet.ShouldProcess("$($_)", "Remove Tag")) {
                Invoke-Nexus -Urislug $urislug -Method 'DELETE'
            }
        }
    }
}