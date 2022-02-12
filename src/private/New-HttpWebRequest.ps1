function New-HttpWebRequest
{
    <#
    .SYNOPSIS
    Creates a new [System.Net.HttpWebRequest] ready for file transmission.

    .DESCRIPTION
    Creates a new [System.Net.HttpWebRequest] ready for file transmission.
    The method will be Put. If the filesize is larger than the buffersize,
    the HttpWebRequest will be configured for chunked transfer.

    .PARAMETER Url
    Url to connect to.

    .PARAMETER Credential
    Credential for authentication at the Url resource.

    .EXAMPLE
    An example

    .NOTES
    Taken from: https://stackoverflow.com/a/48323495
    #>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Url,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [pscredential]$Credential,

        [Parameter(Mandatory=$true)]
        [long]$FileSize,

        [Parameter(Mandatory=$true)]
        [long]$BufferSize
    )

    $webRequest = [System.Net.HttpWebRequest]::Create($Url)
    $webRequest.Timeout = 600 * 1000;
    $webRequest.ReadWriteTimeout = 600 * 1000;
    $webRequest.ProtocolVersion = [System.Net.HttpVersion]::Version11;
    $webRequest.Method = "PUT";
    $webRequest.ContentType = "application/octet-stream";
    $webRequest.KeepAlive = $true;
    $webRequest.UserAgent = "<I use a specific UserAgent>";
    #$webRequest.UserAgent = 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)';
    $webRequest.PreAuthenticate = $true;
    $auth = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Credential.UserName + ":" + $Credential.GetNetworkCredential().Password));
    $webRequest.Headers["Authorization"] = "Basic $auth"

    if (Get-UseChunkedUpload -FileSize $FileSize -BufferSize $BufferSize)
    {
        Write-Verbose "FileSize is greater than BufferSize, using chunked transfer.";
        $webRequest.AllowWriteStreamBuffering = $false;
        $webRequest.SendChunked = $true;
    }
    else
    {
        # Filesize is equal to or smaller than the BufferSize. The file will be transferred in one write.
        # Chunked cannot be used in this case.
        $webRequest.AllowWriteStreamBuffering = $true;
        $webRequest.SendChunked = $false;
        $webRequest.ContentLength = $FileSize;
    }

    return $webRequest;
}