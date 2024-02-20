function Set-NexusContentSelector {
    <#
    .SYNOPSIS
    Updates a Content Selector in Nexus
    
    .DESCRIPTION
    Updates a Content Selector in Nexus
    
    .PARAMETER Name
    The content selector to update
    
    .PARAMETER Description
    A human-readable description
    
    .PARAMETER Expression
    The expression used to identify content
    
    .EXAMPLE
    Set-NexusContentSelector -Name MavenContent -Expression 'format == "maven2" and path =^ "/org/sonatype/nexus"'
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Security/Content%20Selectors/Set-NexusContentSelector/')]
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter({
            param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

            $r = (Get-NexusContentSelector).Name

            if($WordToComplete){
                $r.Where($_ -match "^$WordToComplete")
            }
            else {
                $r
            }
        })]
        [String]
        $Name,

        [Parameter()]
        [String]
        $Description,

        [Parameter()]
        [String]
        $Expression
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {

        $CurrentSettings = Get-NexusContentSelector -Name $Name

        if(-not $Description){
            $Description = $CurrentSettings.Description
        }
        if(-not $Expression){
            $Expression = $CurrentSettings.Expression
        }

        $urislug = "/service/rest/v1/security/content-selectors/$Name"
        $Body = @{
            name = $Name
            description = $Description
            expression = $Expression
        }

        Invoke-Nexus -Urislug $urislug -Body $Body -Method PUT
    }
}