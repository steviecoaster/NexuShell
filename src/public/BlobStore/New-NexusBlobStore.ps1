function New-NexusBlobStore {
    <#
    .SYNOPSIS
    Creates a new blob store
    
    .DESCRIPTION
    Nexus stores artifacts for repositories in blobs. This cmdlet creates a new Nexus Blob for your artifacts
    
    .PARAMETER Type
    The type of Blob Store to create. This can be File, or S3
    
    .PARAMETER Name
    The name of the blob store
    
    .PARAMETER UseQuota
    Enforce a Quota on the blob
    
    .PARAMETER QuotaType
    The type of Quota to enforce
    
    .PARAMETER SoftQuotaInMB
    The storage limit for the Quota
    
    .PARAMETER Path
    The path for the File type blob
    
    .PARAMETER Bucket
    The bucket for the S3 type blob
    
    .PARAMETER Region
    The AWS region of the S3 bucket
    
    .PARAMETER Prefix
    (Optional) Prefix of S3 bucket
    
    .PARAMETER ExpirationDays
    The amount of time to wait after removing an S3 blob store for the underlying bucket to be deleted
    
    .PARAMETER UseAuthentication
    Require authentication for an S3 blob
    
    .PARAMETER AccessKey
    The access key needed to connect an S3 blob when using authentication
    
    .PARAMETER SecretKey
    The Secret Key needed to connect an S3 blob when using authentication
    
    .PARAMETER AssumeRoleARN
    Optional AssumeRoleARN for s3 blob authentication
    
    .PARAMETER SessionTokenARN
    Optional SessionTokenARN for s3 blob authentication
    
    .PARAMETER UseEncryption
    Require encryption of the S3 blob
    
    .PARAMETER EncryptionType
    The type of encryption to use
    
    .PARAMETER KMSKeyId
    If using KMS Encryption the KMS Key Id needed
    
    .EXAMPLE
    New-NexusBlobStore -Name TreasureBlobQuota -Type File -Path C:\blob2 -UseQuota -QuotaType spaceRemainingQuota -SoftQuotaInMB 300

    .EXAMPLE
    New-NexusBlobStore -Name TreasureBlob -Type File -Path C:\blob
    
    .NOTES
    S3 buckets are currently not supported by the cmdlet until I can get S3 for testing
    #>
    [CmdletBinding(HelpUri='https://github.com/steviecoaster/TreasureChest/blob/develop/docs/New-NexusBlobStore.md')]
    Param(
        [Parameter(Mandatory,ParameterSetName="File")]
        [Parameter(Mandatory,ParameterSetName="S3")]
        [ValidateSet('File','S3')]
        [String]
        $Type,

        [Parameter(Mandatory,ParameterSetName="File")]
        [Parameter(Mandatory,ParameterSetName="S3")]
        [String]
        $Name,

        [Parameter(ParameterSetName="File")]
        [Parameter(Mandatory,ParameterSetName="FileQuota")]
        [Switch]
        $UseQuota,

        [Parameter(ParameterSetName="File")]
        [Parameter(Mandatory,ParameterSetName="FileQuota")]
        [ValidateSet('spaceUsedQuota','spaceRemainingQuota')]
        [String]
        $QuotaType,

        [Parameter(ParameterSetName="File")]
        [Parameter(Mandatory,ParameterSetName="FileQuota")]
        [Int]
        $SoftQuotaInMB,

        [Parameter(ParameterSetName="File")]
        [String]
        $Path,

        [Parameter(Mandatory,ParameterSetName="S3Options")]
        [String]
        $Bucket,

        [Parameter(ParameterSetName="S3Options")]
        [String]
        $Region,

        [Parameter(ParameterSetName="S3Options")]
        [String]
        $Prefix,

        [Parameter(ParameterSetName="S3Options")]
        [Int]
        $ExpirationDays = 3,

        [Parameter(Mandatory,ParameterSetName="S3AuthenticationSettings")]
        [Switch]
        $UseAuthentication,

        [Parameter(Mandatory,ParameterSetName="S3AuthenticationSettings")]
        [String]
        $AccessKey,

        [Parameter(Mandatory,ParameterSetName="S3AuthenticationSettings")]
        [String]
        $SecretKey,

        [Parameter(ParameterSetName="S3AuthenticationSettings")]
        [String]
        $AssumeRoleARN,

        [Parameter(ParameterSetName="S3AuthenticationSettings")]
        [String]
        $SessionTokenARN,

        [Parameter(Mandatory,ParameterSetname="S3EncryptionSettings")]
        [Switch]
        $UseEncryption,

        [Parameter(Mandatory,ParameterSetname="S3EncryptionSettings")]
        [ValidateSet('None','S3Managed','KMS')]
        [String]
        $EncryptionType,

        [Parameter(ParameterSetName="S3EncryptionSettings")]
        [String]
        $KMSKeyId

    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/blobstores"
    }

    process {

        switch($PSCmdlet.ParameterSetname){
            'File' {

                $Body = @{
                    name = $Name
                    path = $Path
                }

                if($UseQuota) {
                    $quota = @{
                        type = $QuotaType
                        limit = $SoftQuotaInMB
                    }

                    $Body.Add('softQuota',$quota)
                }

                $Uri = $urislug + '/file'

                Write-Verbose ($Body | ConvertTo-Json)
                try {
                    Invoke-Nexus -UriSlug $Uri -Body $Body -Method 'POST' -ErrorAction Stop
                    $obj = @{
                        Status = 'Success'
                        Name = $Name
                        Type = $Type
                        Path = $Path
                    }

                    if($UseQuota){
                        $options = @{
                            QuotaType = $QuotaType
                            QuotaLimit = $SoftQuotaInMB
                        }

                        $obj.Add('Options',$options)
                    }

                    [pscustomobject]$obj
                }

                catch {
                    $_.exception.Message
                }
            }

            'S3' {

                Write-Warning "S3 buckets are currently unimplemented"
            }
        }

    }
}