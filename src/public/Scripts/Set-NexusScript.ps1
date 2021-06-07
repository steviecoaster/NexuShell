function Set-NexusScript {
    <#
    .SYNOPSIS
    Updates a script saved in Nexus
    
    .DESCRIPTION
    Updates a script saved in Nexus
    
    .PARAMETER Name
    The script to update
    
    .PARAMETER Content
    The new content of the script
    
    .PARAMETER Type
    The new type, if different
    
    .EXAMPLE
    Set-NexusScript -Name SuperAwesomeScript -Content "some awesome groovy code" -Type groovy
    
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

        $urislug = "/service/rest/v1/script/$Name"

        $body = @{
            name = $Name
            content = $Content
            type = $Type
        }
        
        Write-Verbose ($body | ConvertTo-Json)
        Invoke-Nexus -UriSlug $urislug -Body $Body -Method PUT

    }

}