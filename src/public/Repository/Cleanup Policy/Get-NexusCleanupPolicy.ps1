function Get-NexusCleanupPolicy {
    <#
    .SYNOPSIS
    Gets Nexus Cleanup Policy information
    
    .DESCRIPTION
    Gets Nexus Cleanup Policy information
    
    .PARAMETER Name
    The specific policy to retrieve
    
    .EXAMPLE
    Get-NexusCleanupPolicy

    .EXAMPLE
    Get-NexusCleanupPolicy -Name TestPol

    .EXAMPLE
    Get-NexusCleanupPolicy -Name TestPol,ProdPol
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.github.io/NexuShell/Repository/Cleanup%20Policy/Get-NexusCleanupPolicy/')]
    Param(
        [Parameter()]
        [Alias('Policy','CleanupPolicy')]
        [String[]]
        $Name
    )

    process {
        
        $urislug = "/service/rest/internal/cleanup-policies?_dc=$(([DateTime]::ParseExact("01/02/0001 21:08:29", "MM/dd/yyyy HH:mm:ss",$null)).Ticks)"

        if(-not $CleanupPolicy){
            Invoke-Nexus -Urislug $urislug -Method GET
        } else {
            $result = Invoke-Nexus -Urislug $urislug -Method GET

            $result | Where-Object { $_.name -in $CleanupPolicy}
        }
    }

}