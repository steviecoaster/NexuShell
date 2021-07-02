function New-NexusCleanupPolicy {
    <#
    .SYNOPSIS
    Create a new Nexus Cleanup Policy
    
    .DESCRIPTION
    Create a new Nexus Cleanup Policy
    
    .PARAMETER Name
    Unique name for the cleanup policy
    
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
    New-NexusCleanupPolicy -Name SamplePol -Format nuget -ComponentAge 180

    .EXAMPLE
    New-NexusCleanupPolicy -Name SamplePol -Format Go -ComponentUsage 90 -AssetMatcher '*.+'
    
    .NOTES
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Repository/Cleanup%20Policy/New-NexusCleanupPolicy/',DefaultParameterSetName = "Default")]
    Param(
        [Parameter(Mandatory)]
        [Parameter(ParameterSetName = 'Age', Mandatory)]
        [Parameter(ParameterSetName = 'Usage', Mandatory)]

        [String]
        $Name,

        [Parameter(Mandatory)]
        [Parameter(ParameterSetName = 'Age', Mandatory)]
        [Parameter(ParameterSetName = 'Usage', Mandatory)]
        [ValidateSet('All', 'Apt', 'Bower', 'CocoaPods', 'Conan', 'Conda', 'Docker', 'GitLFS', 'Go', 'Helm', 'Maven2', 'Npm', 'Nuget', 'P2', 'PyPi', 'R', 'Raw', 'RubyGems', 'Yum')]
        [String]
        $Format,

        [Parameter()]
        [String]
        $Notes,

        [Parameter(ParameterSetName = 'Age', Mandatory)]
        [Int]
        $ComponentAge,

        [Parameter(ParameterSetName = 'Usage', Mandatory)]
        [Int]
        $ComponentUsage,

        [Parameter(ParameterSetName = 'Age')]
        [Parameter(ParameterSetName = 'Usage')]
        [String]
        $AssetMatcher
    )

    process {

        $urislug = "/service/rest/internal/cleanup-policies?_dc=$(([DateTime]::ParseExact("01/02/0001 21:08:29", "MM/dd/yyyy HH:mm:ss",$null)).Ticks)"

        switch ($PSCmdlet.ParameterSetName) {
            'Age' {
                $Body = @{
                    name                    = $Name
                    notes                   = $Notes
                    criteriaLastBlobUpdated = $ComponentAge
                    format                  = $Format.ToLower()
                }
            }
            'Usage' {
                $Body = @{
                    name                   = $Name
                    notes                  = $Notes
                    criteriaLastDownloaded = $ComponentUsage
                    format                 = $Format.ToLower()
                }
            }
        }

        if ($AssetMatcher) {
            if ($Format -ne 'All') {
                $Body.Add('criteriaAssetRegex', $AssetMatcher)
            } else {
                Write-Warning "Asset matcher will be thrown out as it doesn't apply to All formats"
            }
        }

        Invoke-Nexus -UriSlug $urislug -Body $Body -Method POST
    }
}