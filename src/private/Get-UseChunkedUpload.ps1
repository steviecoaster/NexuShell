function Get-UseChunkedUpload
{
    <#
    .NOTES
    Taken from: https://stackoverflow.com/a/48323495
    #>
    param(
        [Parameter(Mandatory=$true)]
        [long]$FileSize,

        [Parameter(Mandatory=$true)]
        [long]$BufferSize
    )

    return $FileSize -gt $BufferSize;
}