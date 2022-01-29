function Get-BufferSize
{
    <#
    .SYNOPSIS
    Returns a buffer size that is 1% of ByteLength, rounded in whole MB's or at least AtLeast size.

    .DESCRIPTION
    Returns a buffer size that is 1% of ByteLength, rounded to whole MB's or if 1% is smaller than AtLeast, then AtLeast size is returned which is 1MB by default.

    .PARAMETER ByteLength
    Length of the bytes for which to calculate a valid buffer size.

    .PARAMETER AtLeast
    The minimum required buffer size, default 1MB.

    .EXAMPLE
    Get-BufferSize 4283304773

    Returns 42991616 which is 41MB.

    .EXAMPLE
    Get-BufferSize 4283304

    Returns 1048576 which is 1MB.

    .EXAMPLE
    Get-BufferSize 4283304 5MB

    Returns 5242880 which is 5MB.

    .NOTES
    Taken from: https://stackoverflow.com/a/48323495
    #>
    param(
        [Parameter(Mandatory=$true)]
        [long]$ByteLength,

        [long]$AtLeast = 1MB
    )

    [long]$size = $ByteLength / 100;
    if ($size -lt $AtLeast)
    {
        $size = $AtLeast;
    }
    else
    {
        $size = [Math]::Round($size / 1MB) * 1MB;
    }

    return $size;
}