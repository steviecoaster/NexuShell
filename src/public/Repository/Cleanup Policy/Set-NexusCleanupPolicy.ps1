function Set-NexusCleanupPolicy {
    <#
    .SYNOPSIS
    Updates a Nexus Cleanup Policy
    
    .DESCRIPTION
    Updates a Nexus Cleanup Policy
    
    .PARAMETER Name
    The cleanup policy to update
    
    .PARAMETER Format
    The format that this cleanup policy can be applied to
    
    .PARAMETER Notes
    Additional details about the policy
    
    .PARAMETER ComponentAge
    Remove components that were published over this many days
    
    .PARAMETER ComponentUsage
    Remove components that haven't been downloaded in this many days
    
    .PARAMETER AssetMatcher
    Remove components that have at least one asset name matching the following regular expression pattern
    
    .EXAMPLE
    Set-NexusCleanupPolicy -Name TestPol -Notes "New notes here" -ComponentAge 60
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusCleanupPolicy).Name

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                }

                else {
                    $r
                }
            })]
        [String]
        $Name,

        [ValidateSet('All', 'Apt', 'Bower', 'CocoaPods', 'Conan', 'Conda', 'Docker', 'GitLFS', 'Go', 'Helm', 'Maven2', 'Npm', 'Nuget', 'P2', 'PyPi', 'R', 'Raw', 'RubyGems', 'Yum')]
        [String]
        $Format,

        [Parameter()]
        [String]
        $Notes,

        [Int]
        $ComponentAge,

        [Int]
        $ComponentUsage,

        [String]
        $AssetMatcher
    )

    $currentSettings = Get-NexusCleanupPolicy -CleanupPolicy $Name

    $currentSettings = [pscustomobject]@{
        Name                    = $Name
        Format                  = $currentSettings.format
        Notes                   = $currentSettings.notes
        CriteriaLastBlobUpdated = $currentSettings.criteriaLastBlobUpdated
        CriteriaLastDownloaded  = $currentSettings.criteriaLastDownloaded
        CriteriaReleaseType     = $currentSettings.criteriaReleaseType
        CriteriaAssetRegex      = $currentSettings.criteriaAssetRegex
        InUseCount              = $currentSettings.inUseCount
    }

    $urislug = "/service/rest/internal/cleanup-policies/$($Name)?_dc=$(([DateTime]::ParseExact("01/02/0001 21=08=29", "MM/dd/yyyy HH=mm=ss",$null)).Ticks)"
    
    $Body = @{
        name                    = $Name
        notes                   = if($Notes){ $Notes } else { $currentSettings.Notes}
        criteriaLastDownloaded  = if($ComponentUsage) { $ComponentUsage} else {$currentSettings.CriteriaLastDownloaded}
        criteriaLastBlobUpdated = if($ComponentAge) { $ComponentAge} else {$currentSettings.CriteriaLastBlobUpdated}
        criteriaAssetRegex      = if($AssetMatcher) {$AssetMatcher} else { $currentSettings.CriteriaAssetRegex}
        format                  = if($Format) { $Format.ToLower()} else {$currentSettings.Format}
    }

    Write-Verbose ($Body | ConvertTo-Json)
    Invoke-Nexus -Urislug $urislug -Body $Body -Method PUT
}