function Get-NexusRepository {
    [cmdletBinding(DefaultParameterSetName="default")]
    param(
        [Parameter(ParameterSetName="Type",Mandatory)]
        [String]
        [ValidateSet('apt','bower','cocoapods','conan','conda','docker','gitlfs','go','helm','maven2','npm','nuget','p2','pypi','r','raw','rubygems','yum')]
        $Format,

        [Parameter(ParameterSetName="Name",Mandatory)]
        [String]
        $Name
    )


    begin {

        if(-not $header){
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/repositories"
    }
    process {

        switch($PSCmdlet.ParameterSetName){
            {$Type} {
                $filter = { $_.format -eq $Type}

                $result = Invoke-Nexus -UriSlug $urislug -Method Get
                $result | Where-Object $filter
                
            }

            {$Name} {
                $filter = { $_.name -eq $Name}

                $result = Invoke-Nexus -UriSlug $urislug -Method Get
                $result | Where-Object $filter

            }

            default {
                Invoke-Nexus -UriSlug $urislug -Method Get| ForEach-Object { 
                    [pscustomobject]@{
                        Name = $_.SyncRoot.name
                        Format = $_.SyncRoot.format
                        Type = $_.SyncRoot.type
                        Url = $_.SyncRoot.url
                        Attributes = $_.SyncRoot.attributes
                    }
                }
            }
        }
    }
}