function New-NexusRawComponent {
    <#
    .SYNOPSIS
    Uploads a file to a Raw repository
    
    .DESCRIPTION
    Uploads a file to a Raw repository
    
    .PARAMETER RepositoryName
    The Raw repository to upload too
    
    .PARAMETER File
    The file to upload
    
    .PARAMETER Directory
    The directory to store the file on the repo
    
    .PARAMETER Name
    The name of the file stored into the repo. Can be different than the file name being uploaded.
    
    .EXAMPLE
    New-NexusRawComponent -RepositoryName GeneralFiles -File C:\temp\service.1234.log

    .EXAMPLE
    New-NexusRawComponent -RepositoryName GeneralFiles -File C:\temp\service.log -Directory logs

    .EXAMPLE
    New-NexusRawComponent -RepositoryName GeneralFile -File C:\temp\service.log -Directory logs -Name service.99999.log
    
    .NOTES
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]
        $RepositoryName,

        [Parameter(Mandatory)]
        [String]
        $File,

        [Parameter()]
        [String]
        $Directory,

        [Parameter()]
        [String]
        $Name = (Split-Path -Leaf $File)
    )

    process {

        if(-not $Directory){
            $urislug = "/repository/$($RepositoryName)/$($Name)"
        }
        else {
            $urislug = "/repository/$($RepositoryName)/$($Directory)/$($Name)"

        }
        $UriBase = "$($protocol)://$($Hostname):$($port)"
        $Uri = $UriBase + $UriSlug


        $params = @{
            Uri         = $Uri
            Method      = 'PUT'
            ContentType = 'text/plain'
            InFile        = $File
            Headers     = $header
            UseBasicParsing = $true
        }

        $null = Invoke-WebRequest @params        
    }
}