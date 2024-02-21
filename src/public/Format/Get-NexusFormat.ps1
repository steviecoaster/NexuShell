function Get-NexusFormat {
    <#
    .SYNOPSIS
    Returns detailed format information
    
    .DESCRIPTION
    Returns detailed information about the upload specifications for each format supported
    
    .PARAMETER RepositoryFormat
    Retrieve information about a specific format
    
    .EXAMPLE
    Get-NexusFormat

    .EXAMPLE
    Get-NexusFormat -RepositoryFormat nuget
    #>
    [Cmdletbinding(HelpUri='https://nexushell.dev/Formats/Get-NexusFormat/')]
    Param(
        [Parameter()]
        [Alias('Format')]
        [ValidateSet('helm',
            'r',
            'pypi',
            'docker',
            'yum',
            'rubygems',
            'nuget',
            'npm',
            'raw',
            'apt',
            'maven2'
        )]
        [String]
        $RepositoryFormat
    )
    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = if (-not $RepositoryFormat) {
            "/service/rest/v1/formats/upload-specs"
        }
        else {
            "/service/rest/v1/formats/$RepositoryFormat/upload-specs"
        }
    }
    process {
        Invoke-Nexus -UriSlug $urislug -Method 'GET'
    }
}
