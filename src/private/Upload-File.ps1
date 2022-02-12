function Upload-File
{
    <#
    .SYNOPSIS
    Uploads a file to the Nexus repository.

    .DESCRIPTION
    Uploads a file to the Nexus repository.
    If the file was uploaded successfully, the url via which the resource can be downloaded is returned.

    .PARAMETER Url
    The Url where the resource should be created.
    Please note that underscores and dots should be encoded, otherwise the Nexus repository does not accept the upload.

    .PARAMETER File
    The file that should be uploaded.

    .PARAMETER Credential
    Credential used for authentication at the Nexus repository.

    .EXAMPLE
    Upload-File -Url https://nexusrepo.domain.com/repository/repo-name/myfolder/myfile%2Eexe -File (Get-ChildItem .\myfile.exe) -Credential (Get-Credential)

    .OUTPUTS
    If the file was uploaded successfully, the url via which the resource can be downloaded.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Url,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.IO.FileInfo]$File,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [pscredential]$Credential
    )

    Write-Verbose "Upload-File Url:$Url"

    Configure-Tls -Url $Url;

    $fileSizeBytes = $File.Length;
    #$bufSize = Get-BufferSize $fileSizeBytes;
    $bufSize = 4 * 1MB;
    Write-Verbose ("FileSize is {0} bytes ({1:N0}MB). BufferSize is {2} bytes ({3:N0}MB)" -f $fileSizeBytes,($fileSizeBytes/1MB),$bufSize,($bufSize/1MB));
    if (Get-UseChunkedUpload -FileSize $fileSizeBytes -BufferSize $bufSize)
    {
        Write-Verbose "Using chunked upload. Send pre-auth first.";
        Send-PreAuthenticate -Url $Url -Credential $Credential;
    }

    $progressActivityMessage = ("Sending file {0} - {1} bytes" -f $File.Name, $File.Length);
    $webRequest = New-HttpWebRequest -Url $Url -Credential $Credential -FileSize $fileSizeBytes -BufferSize $bufSize;
    $chunk = New-Object byte[] $bufSize;
    $bytesWritten = 0;
    $fileStream = [System.IO.File]::OpenRead($File.FullName);
    $requestStream = $WebRequest.GetRequestStream();
    try
    {
        while($bytesRead = $fileStream.Read($chunk,0,$bufSize))
        {
            $requestStream.Write($chunk, 0, $bytesRead);
            $requestStream.Flush();
            $bytesWritten += $bytesRead;
            $progressStatusMessage = ("Sent {0} bytes - {1:N0}MB" -f $bytesWritten, ($bytesWritten / 1MB));
            Write-Progress -Activity $progressActivityMessage -Status $progressStatusMessage -PercentComplete ($bytesWritten/$fileSizeBytes*100);
        }
    }
    catch
    {
        throw;
    }
    finally
    {
        if ($fileStream)
        {
            $fileStream.Close();
        }
        if ($requestStream)
        {
            $requestStream.Close();
            $requestStream.Dispose();
            $requestStream = $null;
        }
        Write-Progress -Activity $progressActivityMessage -Completed;
    }

    # Read the response.
    $response = $null;
    try
    {
        $response = $webRequest.GetResponse();
        Write-Verbose ("{0} responded with {1} at {2}" -f $response.Server,$response.StatusCode,$response.ResponseUri);
        return $response.ResponseUri;
    }
    catch
    {
        if ($_.Exception.InnerException -and ($_.Exception.InnerException -like "*bad request*"))
        {
            throw ("ERROR: " + $_.Exception.InnerException.Message + " Possibly the file already exists or the content type of the file does not match the file extension. In that case, disable MIME type validation on the server.")
        }

        throw;
    }
    finally
    {
        if ($response)
        {
            $response.Close();
            $response.Dispose();
            $response = $null;
        }
        if ($webRequest)
        {
            $webRequest = $null;
        }
    }
}