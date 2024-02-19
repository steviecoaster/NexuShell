function Set-NexusTag {
    <#
    .SYNOPSIS
    Sets tag metadata for an existing tag
    
    .DESCRIPTION
    This command provides a mechanism to update tag metadata for existing tags within a Sonatype Nexus installation
    
    .PARAMETER Tag
    The tag to update
    
    .PARAMETER Attributes
    A hashtable of attributes to apply to the tag
    
    .EXAMPLE
    Set-NexusTag -Name 'Example' -Attributes @{ foo = 'bar' ; bazz = 'bizz'}
    
    .LINK
    https://help.sonatype.com/en/tagging.html
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Tags/Set-NexusTag/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Tag,

        [Parameter(Mandatory)]
        [hashtable]
        $Attributes
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
        
        $urislug = '/service/rest/v1/tags/{0}' -f $Tag
    }

    process {
        $Body = @{
            attributes = $Attributes
        }
        Invoke-Nexus -UriSlug $urislug -Method PUT -Body $Body
    }
}