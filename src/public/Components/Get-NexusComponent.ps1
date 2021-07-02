function Get-NexusComponent {
    <#
    .SYNOPSIS
    Retrieve asset information from Nexus
    
    .DESCRIPTION
    Retrieve asset informatino from Nexus
    
    .PARAMETER RepositoryName
    The repository to query for components
    
    .PARAMETER Id
    A specific asset to retrieve
    
    .EXAMPLE
    Get-NexusAsset -RepositoryName Dev

    .EXAMPLE
    Get-NexusAsset -Id RGV2OmM2MGJjNmI5NjEyZjQ3ZDM5ZTc2ZmMwNTI1ODg0M2Rj
    
    .NOTES
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Components/Get-NexusComponent/',DefaultParameterSetName="repo")]
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
            $urislug = "/service/rest/v1/components/$($Id)"
            Invoke-Nexus -Urislug $urislug -Method GET
        }

        else {
            $urislug = "/service/rest/v1/components?repository=$($RepositoryName)"

            $result = Invoke-Nexus -Urislug $urislug -Method GET

            $result.items

            if ($($result.continuationToken)) {

                $urislug = "/service/rest/v1/components?continuationToken=$($result.continuationToken)&repository=$($RepositoryName)"
                $result = Invoke-Nexus -Urislug $urislug -Method GET
                $result.items
            }
        }
    }
}