function Set-NexusRoutingRule {
    <#
    .SYNOPSIS
    Updates a Nexus routing rule
    
    .DESCRIPTION
    Updates a Nexus routing rule
    
    .PARAMETER Name
    The name of the rule

    .PARAMETER Description
    A brief explanation of the routing rule
    
    .PARAMETER Mode
    Allow the connection, or block the connection
    
    .PARAMETER Matchers
    Regex strings to match for the route
    
    .EXAMPLE
    Set-NexusRoutingRule -Name BlockNuGet -Mode Block -Matchers 'NuGet','[\w]Nuget.+'
    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://steviecoaster.github.io/NexuShell/Set-NexusRoutingRule/')]
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter( {
            param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

            $r = (Get-NexusRoutingRule).name

            if ($WordToComplete) {
                $r.Where($_ -match "^$WordToComplete")
            }
            else {
                $r
            }
        }
    )]
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

        $urislug = "/service/rest/v1/routing-rules/$Name"
    }

    process {

        $Body = @{
            name = $Name
            description = $Description
            mode = $Mode.ToUpper()
            matchers = @($Matchers)
        }

        Write-Verbose $($Body | ConvertTo-Json)
        Invoke-Nexus -UriSlug $urislug -Body $Body -Method PUT

    }
}