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
        [Array]
        $BodyAsArray,

        [Parameter()]
        [String]
        $BodyAsString,

        [Parameter()]
        [SecureString]
        $BodyAsSecureString,

        [Parameter()]
        [String]
        $File,

        [Parameter()]
        [String]
        $ContentType = 'application/json',

        [Parameter(Mandatory)]
        [String]
        $Method,

        [Parameter()]
        [hashtable]
        $Headers
    )
    process {
        $UriBase = "$($protocol)://$($Hostname):$($port)$($ContextPath)"
        $Uri = $UriBase + $UriSlug
        if ($Headers) {
            $local:header = $script:header.Clone()
            $Headers.Keys.ForEach{
                $header[$_] = $Headers[$_]
            }
        }
        $Params = @{
            Headers = $header
            ContentType = $ContentType
            Uri = $Uri
            Method = $Method
            UseBasicParsing = $true
        }

        if($Body){
            $Params.Add('Body',$($Body | ConvertTo-Json -Depth 3))
        }

        if($BodyAsArray){
            $Params.Add('Body',$($BodyAsArray | ConvertTo-Json -Depth 3))
        }

        if($BodyAsString){
            $Params.Add('Body',$BodyAsString)
        }

        if($BodyAsSecureString){
            $Params.Add(
                'Body',
                [Runtime.InteropServices.Marshal]::PtrToStringBSTR(
                    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($BodyAsSecureString)
                )
            )
        }

        if($File){
            $Params.Remove('ContentType')
            $Params.Add('InFile',$File)
        }

        try {
            Invoke-RestMethod @Params -ErrorAction Stop
        } catch {
            try {
                $JsonMessage = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction Stop
            } catch {<# Not a Json message #>}
            if ($JsonMessage) {
                # If there's a message from the server, display it appropriately
                Write-Error -Message $Message -Exception $_.Exception
            } else {
                # Otherwise, rethrow
                throw
            }
        }
    }
}