function New-NexusSupportZip {
    <#
    .SYNOPSIS
    Prepares a support zip file on your Nexus Server
    
    .DESCRIPTION
    Prepares a support zip file on your Nexus Server
    
    .PARAMETER IncludeSystemInfo
    Includes system info in the zip
    
    .PARAMETER IncludeThreadDump
    Includes a thread dump in the zip
    
    .PARAMETER IncludeMetrics
    Includes metrics in the zip
    
    .PARAMETER IncludeConfiguration
    Includes server configuration in the zip
    
    .PARAMETER IncludeSecurity
    Include security information in the zip
    
    .PARAMETER IncludeNexusLog
    Include the nexus log in the zip
    
    .PARAMETER IncludeTaskLog
    Include the task log in the zip
    
    .PARAMETER IncludeAuditLog
    Include the audit log in the zip
    
    .PARAMETER IncludeJmx
    Include the jmx configuration in the zip
    
    .PARAMETER LimitFileSize
    Limit the output size of files in the zip
    
    .PARAMETER LimitZipSizes
    Limit the overall size of the zip
    
    .EXAMPLE
    New-NexusSupportZip -IncludeNexusLog -IncludeConfiguration
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Support/New-NexusSupportZip/')]
    Param(
        [Parameter()]
        [Switch]
        $IncludeSystemInfo,

        [Parameter()]
        [Switch]
        $IncludeThreadDump,

        [Parameter()]
        [Switch]
        $IncludeMetrics,

        [Parameter()]
        [Switch]
        $IncludeConfiguration,

        [Parameter()]
        [Switch]
        $IncludeSecurity,

        [Parameter()]
        [Switch]
        $IncludeNexusLog,

        [Parameter()]
        [Switch]
        $IncludeTaskLog,

        [Parameter()]
        [Switch]
        $IncludeAuditLog,

        [Parameter()]
        [Switch]
        $IncludeJmx,

        [Parameter()]
        [Switch]
        $LimitFileSize,

        [Parameter()]
        [Switch]
        $LimitZipSizes
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

    }

    process {
        $Body = @{
            systemInformation = [bool]$IncludeSystemInfo
            threadDump        = [bool]$IncludeThreadDump
            metrics           = [bool]$IncludeMetrics
            configuration     = [bool]$IncludeConfiguration
            security          = [bool]$IncludeSecurity
            log               = [bool]$IncludeNexusLog
            taskLog           = [bool]$IncludeTaskLog
            auditLog          = [bool]$IncludeAuditLog
            jmx               = [bool]$IncludeJmx
            limitFileSizes    = [bool]$LimitFileSize
            limitZipSize      = [bool]$LimitZipSizes
        }

        $urislug = '/service/rest/v1/support/supportzippath'
        Write-Verbose ($Body | ConvertTo-Json)
        $result = Invoke-Nexus -Urislug $urislug -Body $Body -Method POST
            
        [pscustomobject]@{
            File      = $result.file
            Name      = $result.name
            Size      = "$([Math]::Round($result.size,2)) MB"
            Truncated = $result.truncated
        }
            
    }
}