function New-NexusScript {
    <#
    .SYNOPSIS
    Stores a new script in Nexus
    
    .DESCRIPTION
    Stores a new script in Nexus
    
    .PARAMETER Name
    The name of the script
    
    .PARAMETER Content
    The contents of the script
    
    .PARAMETER Type
    The language of the script
    
    .EXAMPLE
    New-NexusScript -Name TestScript -Content 'Get-ComputerInfo' -Type powershell
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter(Mandatory)]
        [String]
        $Content,

        [Parameter(Mandatory)]
        [String]
        $Type
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {

        $urislug = "/service/rest/v1/script"

        $body = @{
            name = $Name
            content = $Content
            type = $Type
        }
        
        Write-Verbose ($body | ConvertTo-Json)
        Invoke-Nexus -UriSlug $urislug -Body $Body -Method POST

    }
}