function New-NexusContentSelector {
    <#
    .SYNOPSIS
    Creates a new Content Selector in Nexus
    
    .DESCRIPTION
    Creates a new Content Selector in Nexus
    
    .PARAMETER Name
    The content selector name cannot be changed after creation
    
    .PARAMETER Description
    A human-readable description
    
    .PARAMETER Expression
    The expression used to identify content
    
    .EXAMPLE
    New-NexusContentSelector -Name MavenContent -Expression 'format == "maven2" and path =^ "/org/sonatype/nexus"'
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter()]
        [String]
        $Description,

        [Parameter(Mandatory)]
        [String]
        $Expression
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {

        $urislug = '/service/rest/v1/security/content-selectors'
        $Body = @{
            name = $Name
            description = $Description
            expression = $Expression
        }

        Invoke-Nexus -Urislug $urislug -Body $Body -Method POST
    }
}