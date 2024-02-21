function Get-NexusRepository {
    <#
    .SYNOPSIS
    Returns info about configured Nexus repository
    
    .DESCRIPTION
    Returns details for currently configured repositories on your Nexus server
    
    .PARAMETER Format
    Query for only a specific repository format. E.g. nuget, maven2, or docker
    
    .PARAMETER Name
    Query for a specific repository by name
    
    .EXAMPLE
    Get-NexusRepository

    .EXAMPLE
    Get-NexusRepository -Format nuget

    .EXAMPLE
    Get-NexusRepository -Name CompanyNugetPkgs
    #>
    [cmdletBinding(HelpUri='https://nexushell.dev/Get-NexusRepository/',DefaultParameterSetName="default")]
    param(
        [Parameter(ParameterSetName="Format",Mandatory)]
        [String]
        [ValidateSet('apt','bower','cocoapods','conan','conda','docker','gitlfs','go','helm','maven2','npm','nuget','p2','pypi','r','raw','rubygems','yum')]
        $Format,

        [Parameter(ParameterSetName="Type",Mandatory)]
        [String]
        [ValidateSet('hosted','group','proxy')]
        $Type,

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
            {$Format} {
                $filter = { $_.format -eq $Format}

                $result = Invoke-Nexus -UriSlug $urislug -Method Get
                $result | Where-Object $filter
                
            }

            {$Name} {
                $filter = { $_.name -eq $Name }

                $result = Invoke-Nexus -UriSlug $urislug -Method Get
                $result | Where-Object $filter

            }

            {$Type} {
                $filter = { $_.type -eq $Type }
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