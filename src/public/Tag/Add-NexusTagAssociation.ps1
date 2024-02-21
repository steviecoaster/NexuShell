function Add-NexusTagAssociation {
    <#
    .SYNOPSIS
    Tags a component with the provided tag name based on the search query parameters
    
    .DESCRIPTION
    Tags a component based on the Query terms based via hashtable to the API endpoint.
    
    .PARAMETER Tag
    The tag to apply to the component(s)
    
    .PARAMETER SearchQuery
    A hashtable of search parameters by which to tag components
    
    .EXAMPLE
    Add-NexusTag -Tag SampleTag -SearchQuery @{ format = 'nuget' ; repository = 'ChocolateyPackages'}
    
    .LINK
    https://help.sonatype.com/en/tagging.html
    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/Tags/Add-NexusTagAssociation/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Tag,

        [Parameter()]
        [hashtable]
        $SearchQuery
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
            Headers = $header
            ContentType = 'application/json'
            Uri = $tagUrl
            Method = 'POST'
            UseBasicParsing = $true
        }

        Invoke-RestMethod @Params
    }
}