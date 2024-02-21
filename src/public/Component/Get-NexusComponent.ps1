function Get-NexusComponent {
    <#
    .SYNOPSIS
    Retrieve component information from Nexus
    
    .DESCRIPTION
    Retrieve component information from Nexus
    
    .PARAMETER RepositoryName
    The repository to query for components
    
    .PARAMETER Id
    A specific component to retrieve
    
    .EXAMPLE
    Get-NexusComponent -RepositoryName Dev

    .EXAMPLE
    Get-NexusComponent -Id RGV2OmM2MGJjNmI5NjEyZjQ3ZDM5ZTc2ZmMwNTI1ODg0M2Rj
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/Components/Get-NexusComponent/', DefaultParameterSetName = "repo")]
    Param(
        [Parameter(ParameterSetName = "repo", Mandatory)]
        [String]
        $RepositoryName,

        [Parameter(ParameterSetName = "Id", Mandatory)]
        [String]
        $Id
    )

    process {

        if ($Id) {
            $urislug = "/service/rest/v1/components/$($Id)"
            Invoke-Nexus -Urislug $urislug -Method GET
        }

        else {

            $resultCollection = [System.Collections.Generic.List[psobject]]::new()
            $urislug = "/service/rest/v1/components?repository=$($RepositoryName)"

            $result = Invoke-Nexus -Urislug $urislug -Method GET

            $result.items | Foreach-Object {
                $temp = [PsCustomObject]@{
                    Id         = $_.id
                    Repository = $_.repository
                    Format     = $_.format
                    Group      = $_.group
                    Name       = $_.name
                    Version    = $_.version
                    Assets     = $_.assets
                }
                $resultCollection.Add($temp)
            }

            do {
                $urislug = "/service/rest/v1/components?repository=$($RepositoryName)&continuationToken=$($result.continuationToken)"
                $result = Invoke-Nexus -Urislug $urislug -Method GET
                
                $result.items | Foreach-Object {
                    $temp = [PsCustomObject]@{
                        Id         = $_.id
                        Repository = $_.repository
                        Format     = $_.format
                        Group      = $_.group
                        Name       = $_.name
                        Version    = $_.version
                        Assets     = $_.assets
                    }
                    $resultCollection.Add($temp)
                }
            }
            
            while ($null -ne $result.continuationToken)
            $resultCollection

        }
    }
}