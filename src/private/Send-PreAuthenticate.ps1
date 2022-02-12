function Send-PreAuthenticate
{
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Url,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [pscredential]$Credential
    )

    $response = $null;
    try
    {
        [System.Uri]$uri = $Url;
        $repositoryAuthority = (($uri.GetLeftPart([System.UriPartial]::Authority)).TrimEnd('/') + '/');
        Write-Verbose "Send-PreAuthenticate - Sending HEAD to $repositoryAuthority";
        $wr = [System.Net.WebRequest]::Create($repositoryAuthority);
        $wr.Method = "HEAD";
        $wr.PreAuthenticate = $true;
        $auth = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Credential.UserName + ":" + $Credential.GetNetworkCredential().Password));
        $wr.Headers["Authorization"] = "Basic $auth"
        $response = $wr.GetResponse();
    }
    finally
    {
        if ($response)
        {
            $response.Close();
            $response.Dispose();
            $response = $null;
        }
    }
}