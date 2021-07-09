function Get-NexusScript {
    <#
    .SYNOPSIS
    Returns scripts stored for execution in Nexus
    
    .DESCRIPTION
    Returns scripts stored for execution in Nexus

    .PARAMETER Name
    Return a specific script's details
    
    .EXAMPLE
    Get-NexusScript

    .EXAMPLE
    Get-NexusScript -Name SuperAwesomeScript
    
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

        if (-not $Name) {
            $urislug = "/service/rest/v1/script"
            $result = Invoke-Nexus -UriSlug $urislug -Method GET
            $result | ForEach-Object {
                [pscustomobject]@{
                    Name    = $_.name
                    Content = $_.content
                    Type    = $_.type
                }
            }
    
        }
        else {

            $Name | Foreach-Object {
                $urislug = "/service/rest/v1/script/$_"
                $result = Invoke-Nexus -UriSlug $urislug -Method GET
                $result | ForEach-Object {
                    [pscustomobject]@{
                        Name    = $_.name
                        Content = $_.content
                        Type    = $_.type
                    }
                }
            }
        }

    }
}