function New-NexusTag {
<#
.SYNOPSIS
Create a tag

.DESCRIPTION
Create a tag in Nexus Repository. Useful with CI/CD platforms, similar to git tags.

.PARAMETER Tag
The friendly name of the tag

.PARAMETER Attributes
Any additional metadata you wish to tag a component with

.EXAMPLE
 $tag = @{
    name = 'SampleTag'
    attributes = @{
        jvm = '9'
        builtby = 'Jenkins'
    }
 }

 New-NexusTag @tag

.LINK
https://help.sonatype.com/en/tagging.html
#>
    [CmdletBinding(HelpUri='https://nexushell.dev/Tags/New-NexusTag/')]
    Param(
        [Parameter(Mandatory)]
        [ValidateLength(1,256)]
        [String]
        $Tag,

        [Parameter()]
        [hashtable]
        $Attributes
    )
    begin{
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
        
        $urislug = '/service/rest/v1/tags'

        if ($Tag.Length -gt 256) {
            throw "Name cannot exceed 256 characters."
        }
        
        if ($Tag -notmatch '^[a-zA-Z0-9_.-]+$') {
            throw "Name can only contain letters, numbers, underscores, hyphens, and dots."
        }
        
        if ($Tag -match '^[_\.]') {
            throw "Name cannot start with an underscore or dot."
        }
    }

    process {

        $body = @{
            name = $Tag
            attributes = $Attributes
        }

        Invoke-Nexus -Urislug $urislug -Body $body -Method POST
    }

}