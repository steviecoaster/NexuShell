function Get-NexusBlobStore {
    [CmdletBinding(DefaultParameterSetName = "Default")]
    Param(
        [Parameter(Mandatory, ParameterSetName = "Name")]
        [String]
        $Name,
        
        [Parameter(Mandatory, ParameterSetName = "Type")]
        [Parameter(Mandatory, ParameterSetName = "Name")]
        [ValidateSet('File', 'S3')]
        [String]
        $Type,

        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "Type")]
        [Switch]
        $Detailed
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/blobstores"
    }

    process {

        switch ($PSCmdlet.ParameterSetName) {
            
            { $Name } {
                if (-not $Detailed) {
                    switch ($Type) {
                        'File' {
                            $urlType = '/file'
                            $Uri = $urislug + $urlType + "/$Name"
    
                            Invoke-Nexus -UriSlug $Uri -Method 'GET'
                        }
    
                        'S3' {
                            $urlType = '/s3'
                            $Uri = $urislug + $urlType + "/$Name"
    
                            Invoke-Nexus -UriSlug $Uri -Method 'GET'
                        }
                    }

                }

                else {
                    $result = Invoke-Nexus -UriSlug $urislug -Method 'GET'
                    $result | Where-Object { $_.name -eq $Name }
                }
                
            }

            default {
                Invoke-Nexus -UriSlug $urislug -Method 'GET'

            }
        }
        
    }
}