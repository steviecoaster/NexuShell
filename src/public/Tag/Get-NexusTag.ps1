function Get-NexusTag {
    [Cmdletbinding(HelpUri = 'https://nexushell.dev/Tags/Get-NexusTag/')]
    Param(
        [Parameter()]
        [String]
        $Name
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = if (-not $Name) {
            '/service/rest/v1/tags'
        }
        else {
            "/service/rest/v1/tags/$Name"
        }

    }

    process {
        if(-not $Name){
            $result = Invoke-Nexus -Urislug $urislug -Method GET
            $result.items
        } else {
            Invoke-Nexus -UriSlug $urislug -Method GET
        }
    }
 
}