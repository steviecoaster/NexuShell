function Configure-Tls
{
    <#
    .NOTES
    Take from: https://stackoverflow.com/a/48323495
    #>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Url
    )

    [System.Uri]$uri = $Url;
    if ($uri.Scheme -eq "https")
    {
        Write-Verbose "Using TLS 1.2";
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
    }
}