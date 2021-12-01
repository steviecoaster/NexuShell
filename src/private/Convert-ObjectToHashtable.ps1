function Convert-ObjectToHashtable {
    <#
    .SYNOPSIS
    Converts a PSObject to a Hashtable

    .DESCRIPTION
    Invoke-Nexus outputs PSObjects, due to the underlying use of Invoke-RestMethod.
    Invoke-Nexus takes a Hashtable as body. This allows some pass-between.

    .PARAMETER InputObject
    The object to convert.

    .EXAMPLE
    Get-NexusBlobStorage -Name default -Type File | Convert-ObjectToHashtable
    #>
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject
    )
    process {
        $Hashtable = @{}
        $InputObject.PSObject.Properties.ForEach{
            $Hashtable[$_.Name] = $_.Value
        }

        $Hashtable
    }
}