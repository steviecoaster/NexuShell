function New-NexusRoutingRule {
    <#
    .SYNOPSIS
    Create a new Nexus routing rule
    
    .DESCRIPTION
    Create a new Nexus routing rule
    
    .PARAMETER Name
    The name of the rule

    .PARAMETER Description
    A brief explanation of the routing rule
    
    .PARAMETER Mode
    Allow the connection, or block the connection
    
    .PARAMETER Matchers
    Regex strings to match for the route
    
    .EXAMPLE
    New-NexusRoutingRule -Name BlockNuGet -Mode Block -Matchers 'NuGet','[\w]Nuget.+'
    
    .NOTES
    General notes
    #>
    [CmdletBinding(HelpUri = 'https://steviecoaster.dev/TreasureChest/New-NexusRoutingRule/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter()]
        [String]
        $Description,

        [Parameter(Mandatory)]
        [ValidateSet('Allow','Block')]
        [String]
        $Mode,

        [Parameter(Mandatory)]
        [String[]]
        $Matchers
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/routing-rules"
    }

    process {

        $Body = @{
            name = $Name
            description = $Description
            mode = $Mode.ToUpper()
            matchers = @($Matchers)
        }

        Write-Verbose $($Body | ConvertTo-Json)
        Invoke-Nexus -UriSlug $urislug -Body $Body -Method POST

    }
}