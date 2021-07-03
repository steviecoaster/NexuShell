function New-NexusNugetComponent {
    <#
    .SYNOPSIS
    Uploads a NuGet package to Nexus through the Components API
    
    .DESCRIPTION
    Uploads a NuGet package to Nexus through the Components API
    
    .PARAMETER RepositoryName
    The repository to upload too
    
    .PARAMETER NuGetComponent
    The NuGet package to upload
    
    .EXAMPLE
    New-NexusNugetComponent -RepositoryName ProdNuGet -NuGetComponent C:\temp\awesomepackage.0.1.0.nupkg
    
    .NOTES
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]
        $RepositoryName,

        [Parameter(Mandatory)]
        [ValidateScript( {
                Test-Path $_
            })]
        [String]
        $NuGetComponent
    )

    process {

        $urislug = "/service/rest/v1/components?repository=$($RepositoryName)"
        $UriBase = "$($protocol)://$($Hostname):$($port)$($ContextPath)"
        $Uri = $UriBase + $UriSlug

        $boundary = [System.Guid]::NewGuid().ToString(); 
        $ContentType = 'application/octet-stream'
        $FileStream = [System.IO.FileStream]::new($NuGetComponent, [System.IO.FileMode]::Open)
        $FileHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new('form-data')
        $FileHeader.Name = 'nuget.asset'
        $FileHeader.FileName = Split-Path -leaf $NuGetComponent
        $FileContent = [System.Net.Http.StreamContent]::new($FileStream)
        $FileContent.Headers.ContentDisposition = $FileHeader
        $FileContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse($ContentType)

        $MultipartContent = [System.Net.Http.MultipartFormDataContent]::new()
        $MultipartContent.Add($FileContent)

        $params = @{
            Uri         = $Uri
            Method      = 'POST'
            ContentType = "multipart/form-data; boundary=----WebKitFormBoundary$($Boundary)"
            Body        = $MultipartContent
            Headers     = $header
            UseBasicParsing = $true
        }

        $null = Invoke-WebRequest @params
        
    }
    

}