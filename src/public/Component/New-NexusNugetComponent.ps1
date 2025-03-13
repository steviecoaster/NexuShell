function New-NexusNugetComponent {
    <#
    .SYNOPSIS
    Uploads a NuGet package to Nexus through the Components API

    .DESCRIPTION
    Uploads a NuGet package to Nexus through the Components API

    .PARAMETER RepositoryName
    The repository to upload to

    .PARAMETER NuGetComponent
    The NuGet package to upload
    
    .EXAMPLE
    New-NexusNugetComponent -RepositoryName ProdNuGet -NuGetComponent C:\temp\awesomepackage.0.1.0.nupkg

    .EXAMPLE
    Get-ChildItem ~\Downloads\ -Filter *.nupkg | New-NexusNugetComponent -RepositoryName ChocolateyTest
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]
        $RepositoryName,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("PSPath")]
        [ValidateScript( {
                Test-Path $_
            })]
        [String]
        $NuGetComponent
    )
    begin {
        if (-not ('System.Net.Http.HttpClient' -as [type])) {
            Add-Type -AssemblyName 'System.Net.Http'
        }

        $Uri = "$($protocol)://$($Hostname):$($port)$($ContextPath.TrimEnd('/'))/service/rest/v1/components?repository=$($RepositoryName)"

        $Client = [System.Net.Http.HttpClient]::new()
        $Client.DefaultRequestHeaders.Authorization = $header.Authorization
    }
    process {
        try {
            $Content = [System.Net.Http.MultipartFormDataContent]::new()
            $FileName = [System.IO.Path]::GetFileName($NuGetComponent)
            $FileStream = [System.IO.File]::OpenRead((Convert-Path $NuGetComponent))
            $FileContent = [System.Net.Http.StreamContent]::new($FileStream)
            $Content.Add($FileContent, 'nuget.asset', $FileName)

            $Result = $Client.PostAsync($Uri, $Content).Result
            if ($Result.EnsureSuccessStatusCode()) {
                Write-Verbose "'$($FileName)' was successfully uploaded to '$($RepositoryName)'"
            }
        } catch {
            Write-Error "'$($FileName)' failed to upload to '$($RepositoryName)': $($Result.ReasonPhrase)`n$_"
        } finally {
            if ($Content) {$Content.Dispose()}
            if ($FileStream) {$FileStream.Dispose()}
            if ($FileContent) {$FileContent.Dispose()}
        }
    }
    end {
        if ($Client) {$Client.Dispose()}
    }
}