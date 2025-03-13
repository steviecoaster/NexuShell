function Get-NexusAsset {
    <#
    .SYNOPSIS
    Retrieve asset information from Nexus
    
    .DESCRIPTION
    Retrieve asset informatino from Nexus
    
    .PARAMETER RepositoryName
    The repository to query for assets
    
    .PARAMETER Id
    A specific asset to retrieve
    
    .EXAMPLE
    Get-NexusAsset -RepositoryName Dev

    .EXAMPLE
    Get-NexusAsset -Id RGV2OmM2MGJjNmI5NjEyZjQ3ZDM5ZTc2ZmMwNTI1ODg0M2Rj
    
    .NOTES
    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/Assets/Get-NexusAsset/',DefaultParameterSetName="repo")]
    Param(
        [Parameter(ParameterSetName="repo",Mandatory)]
        [String]
        $RepositoryName,

        [Parameter(ParameterSetName="Id",Mandatory)]
        [String]
        $Id
    )

    process {

        if ($Id) {
            $urislug = "/service/rest/v1/assets/$($Id)"
            Invoke-Nexus -Urislug $urislug -Method GET
        }

        else {
            $urislug = "/service/rest/v1/assets?repository=$($RepositoryName)"

            $result = Invoke-Nexus -Urislug $urislug -Method GET

            $result.items

            while ($($result.continuationToken)) {
                $urislug = "/service/rest/v1/assets?continuationToken=$($result.continuationToken)&repository=$($RepositoryName)"
                $result = Invoke-Nexus -Urislug $urislug -Method GET
                $result.items
            }
        }
    }
}