function Remove-NexusTagAssociation {
    <#
    .SYNOPSIS
    Removes a tag from a component
    
    .DESCRIPTION
    Disassociates a tag from a component within Nexus. Does not remove the tag itself from the system.
    
    .PARAMETER Tag
    The tag to disassociate
    
    .PARAMETER SearchQuery
    The search parameters to find components with the tag to remove
    
    .PARAMETER Force
    Don't prompt to remove the tag
    
    .EXAMPLE
    Remove-NexusTagAssociation -Tag SampleTag -SearchQuery @{ format = 'nuget' ; repository = 'ChocolateyInternal'}
    
    .LINK
    https://help.sonatype.com/en/tagging.html
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High', HelpUri = 'https://nexushell.dev/Tags/Remove-NexusTagAssociation/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Tag,

        [Parameter(Mandatory)]
        [hashtable]
        $SearchQuery,

        [Parameter()]
        [Switch]
        $Force
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
        
        $urislug = '/service/rest/v1/tags/associate/{0}' -f $Tag
    }

    process {
        $UriBase = "$($protocol)://$($Hostname):$($port)$($ContextPath)"
        $Uri = $UriBase + $UriSlug

        $tagUrl = New-HttpQueryString -Uri $uri -QueryParameter $SearchQuery
 
        $Params = @{
            Headers         = $header
            ContentType     = 'application/json'
            Uri             = $tagUrl
            Method          = 'DELETE'
            UseBasicParsing = $true
        }

        if ($Force -and -not $Confirm) {
            $ConfirmPreference = 'None'
            if ($PSCmdlet.ShouldProcess("$($_)", "Remove Tag Association")) {
                Invoke-RestMethod @Params
            }
        }
        else {
            if ($PSCmdlet.ShouldProcess("$($_)", "Remove Tag Association")) {
                Invoke-RestMethod @Params
            }
        }
    }
}