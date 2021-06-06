function Get-NexusRoutingRule {
    <#
    .SYNOPSIS
    Get Nexus Routing rule information
    
    .DESCRIPTION
    Get Nexus Routing rule information
    
    .PARAMETER Name
    Specific routing rule to return
    
    .EXAMPLE
    Get-NexusRoutingRule

    .EXAMPLE
    Get-NexusRoutingRule -Name NugetRule
    
    .NOTES
    #>
    [CmdletBinding()]
    Param(
        [Parameter()]
        [String[]]
        $Name
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

    }
    process {
        if(-not $Name){
            $urislug = "/service/rest/v1/routing-rules"

            $result = Invoke-Nexus -UriSlug $urislug -Method GET
            $result | ForEach-Object {
                [pscustomobject]@{
                    Name = $_.name
                    Description = $_.description
                    Mode = $_.mode
                    Matchers = $_.matchers
                }
            }
        } else {
            $name | ForEach-Object {
                $urislug = "/service/rest/v1/routing-rules/$_"

                $result = Invoke-Nexus -Urislug $urislug -Method GET
                $result | ForEach-Object {
                    [pscustomobject]@{
                        Name = $_.name
                        Description = $_.description
                        Mode = $_.mode
                        Matchers = $_.matchers
                    }
                }
            }
        }
    }
}