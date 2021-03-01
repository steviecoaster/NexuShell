function Invoke-Nexus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [String]
        $UriSlug,

        [Parameter()]
        [Hashtable]
        $Body,

        [Parameter()]
        [String]
        $ContentType,

        [Parameter(Mandatory)]
        [String]
        $Method

    )
    process {

        $UriBase = "$($protocol)://$($Hostname):$($port)"
        $Uri = $UriBase + $UriSlug
        $Params = @{
            Headers = $header
            ContentType = 'application/json'
            Uri = $Uri
            Method = $Method
        }

        if($Body){
            $Params.Add('Body',$($Body | ConvertTo-Json -Depth 3))
        }

        Invoke-RestMethod @Params
    }
}