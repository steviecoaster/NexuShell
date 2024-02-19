function Get-NexusContentSelector {
    <#
    .SYNOPSIS
    List Nexus Content Selectors
    
    .DESCRIPTION
    List Nexus Content Selectors
    
    .PARAMETER Name
    The content selector name
    
    .EXAMPLE
    Get-NexusContentSelector

    .EXAMPLE
    Get-NexusContentSelector -Name 'MavenSelector'
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Security/Content%20Selectors/Get-NexusContentSelector/')]
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

        if($Name){
            $Name | Foreach-Object {
                $urislug = "/service/rest/v1/security/content-selectors/$_"

                $result = Invoke-Nexus -Urislug $urislug -Method GET

                if($result){
                    [pscustomobject]@{
                        Name = $result.name
                        Description = $result.Description
                        Expression = $result.expression
                    }
                }
                
            }
        } else {
            $urislug = '/service/rest/v1/security/content-selectors'

            $result = Invoke-Nexus -Urislug $urislug -Method GET
            if($result){
                [pscustomobject]@{
                    Name = $result.name
                    Description = $result.Description
                    Expression = $result.expression
                }
            }
        }
    }
}