function Get-NexusStatus {
    <#
    .SYNOPSIS
    Returns Nexus System Status information
    
    .DESCRIPTION
    Returns Nexus System Status information
    
    .PARAMETER VerifyRead
    Verifies that Nexus can accept read requests
    
    .PARAMETER VerifySystem
    Returns system information
    
    .PARAMETER VerifyWrite
    Verifies that Nexus can accpet write requests
    
    .EXAMPLE
    Get-NexusStatus

    Returns system information

    .EXAMPLE
    Get-NexusStatus -VerifyRead

    .EXAMPLE
    Get-NexusStatus -VerifySystem

    .EXAMPLE
    Get-NexusStatus -VerifyWrite

    .EXAMPLE
    Get-NexusStatus -VerifyRead -VerifyWrite -VerifySystem
    
    .NOTES
    General notes
    #>
    [CmdletBinding()]
    Param(
        [Parameter()]
        [Switch]
        $VerifyRead,

        [Parameter()]
        [Switch]
        $VerifySystem,

        [Parameter()]
        [Switch]
        $VerifyWrite
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

    }

    process {
        switch ($true) {
            $VerifyRead { 
                $urislug = '/service/rest/v1/status'
                try {
                    Invoke-Nexus -Urislug $urislug -Method GET
                    Write-Host "System can accept read requests"
                }
                catch {
                    $_.Exception.Message
                }
            }
            $VerifySystem { 
                $urislug = '/service/rest/v1/status/check'
                try {
                    $result = Invoke-Nexus -Urislug $urislug -Method GET

                    [pscustomobject]@{
                        'Available CPUs'            = [pscustomobject]@{
                            Healthy   = $result.'Available CPUs'.healthy
                            Message   = $result.'Available CPUs'.message
                            Error     = $result.'Available CPUs'.error
                            Details   = $result.'Available CPUs'.details
                            Time      = $result.'Available CPUs'.time
                            Duration  = $result.'Available CPUs'.duration
                            Timestamp = $result.'Available CPUs'.timestamp
                        }
                        'Blob Stores'               = [pscustomobject]@{
                            Healthy   = $result.'Blob Stores'.healty
                            Message   = $result.'Blob Stores'.message
                            Error     = $result.'Blob Stores'.error
                            Details   = $result.'Blob Stores'.details
                            Time      = $result.'Blob Stores'.time
                            Duration  = $result.'Blob Stores'.duration
                            Timestamp = $result.'Blob Stores'.timestamp
                        }
                        'Default Admin Credentials' = [pscustomobject]@{
                            Healthy   = $result.'Default Admin Credentials'.healthy
                            Message   = $result.'Default Admin Credentials'.message
                            Error     = $result.'Default Admin Credentials'.error
                            Details   = $result.'Default Admin Credentials'.details
                            Time      = $result.'Default Admin Credentials'.time
                            Duration  = $result.'Default Admin Credentials'.duration
                            Timestamp = $result.'Default Admin Credentials'.timestamp
                        }
                        DefaultRoleRealm            = [pscustomobject]@{
                            Healthy   = $result.DefaultRoleRealm.healthy
                            Message   = $result.DefaultRoleRealm.message
                            Error     = $result.DefaultRoleRealm.error
                            Details   = $result.DefaultRoleRealm.details
                            Time      = $result.DefaultRoleRealm.time
                            Duration  = $result.DefaultRoleRealm.duration
                            Timestamp = $result.DefaultRoleRealm.timestamp
                        }
                        'File Blob Stores Path'     = [pscustomobject]@{
                            Healthy   = $result.'File Blob Stores Path'.healthy
                            Message   = $result.'File Blob Stores Path'.message
                            Error     = $result.'File Blob Stores Path'.error
                            Details   = $result.'File Blob Stores Path'.details
                            Time      = $result.'File Blob Stores Path'.time
                            Duration  = $result.'File Blob Stores Path'.duration
                            Timestamp = $result.'File Blob Stores Path'.timestamp
                        }
                        'File Descriptors'          = [pscustomobject]@{
                            Healthy   = $result.'File Descriptors'.healthy
                            Message   = $result.'File Descriptors'.message
                            Error     = $result.'File Descriptors'.error
                            Details   = $result.'File Descriptors'.details
                            Time      = $result.'File Descriptors'.time
                            Duration  = $result.'File Descriptors'.duration
                            Timestamp = $result.'File Descriptors'.timestamp
                        }
                        'Lifecycle Phase'           = [pscustomobject]@{
                            Healthy   = $result.'Lifecycle Phase'.healthy
                            Message   = $result.'Lifecycle Phase'.message
                            Error     = $result.'Lifecycle Phase'.error
                            Details   = $result.'Lifecycle Phase'.details
                            Time      = $result.'Lifecycle Phase'.time
                            Duration  = $result.'Lifecycle Phase'.duration
                            Timestamp = $result.'Lifecycle Phase'.timestamp
                        }
                        'Read-Only Detector'        = [pscustomobject]@{
                            Healthy   = $result.'Read-Only Detector'.healthy
                            Message   = $result.'Read-Only Detector'.message
                            Error     = $result.'Read-Only Detector'.error
                            Details   = $result.'Read-Only Detector'.details
                            Time      = $result.'Read-Only Detector'.time
                            Duration  = $result.'Read-Only Detector'.duration
                            Timestamp = $result.'Read-Only Detector'.timestamp
                        }
                        Scheduler                   = [pscustomobject]@{
                            Healthy   = $result.Scheduler.healthy
                            Message   = $result.Scheduler.message
                            Error     = $result.Scheduler.error
                            Details   = $result.Scheduler.details
                            Time      = $result.Scheduler.time
                            Duration  = $result.Scheduler.duration
                            Timestamp = $result.Scheduler.timestamp
                        }
                        'Thread Deadlock Detector'  = [pscustomobject]@{
                            Healthy   = $result.'Thread Deadlock Detector'.healthy
                            Message   = $result.'Thread Deadlock Detector'.message
                            Error     = $result.'Thread Deadlock Detector'.error
                            Details   = $result.'Thread Deadlock Detector'.details
                            Time      = $result.'Thread Deadlock Detector'.time
                            Duration  = $result.'Thread Deadlock Detector'.duration
                            Timestamp = $result.'Thread Deadlock Detector'.timestamp
                        }
                        Transactions                = [pscustomobject]@{
                            Healthy   = $result.Transactions.healthy
                            Message   = $result.Transactions.message
                            Error     = $result.Transactions.error
                            Details   = $result.Transactions.details
                            Time      = $result.Transactions.time
                            Duration  = $result.Transactions.duration
                            Timestamp = $result.Transactions.timestamp
                        }
                    }
                
                }
                catch {
                    $_.Exception.Message
                }
            }
            $VerifyWrite { 
                $urislug = '/service/rest/v1/status/writable'
                try {
                    Invoke-Nexus -Urislug $urislug -Method GET
                    Write-Host "System can accept write requests"
                }
                catch {
                    $_.Exception.Message
                }
            }
            default {
                $urislug = '/service/rest/v1/status/check'
                try {
                    $result = Invoke-Nexus -Urislug $urislug -Method GET

                    [pscustomobject]@{
                        'Available CPUs'            = [pscustomobject]@{
                            Healthy   = $result.'Available CPUs'.healthy
                            Message   = $result.'Available CPUs'.message
                            Error     = $result.'Available CPUs'.error
                            Details   = $result.'Available CPUs'.details
                            Time      = $result.'Available CPUs'.time
                            Duration  = $result.'Available CPUs'.duration
                            Timestamp = $result.'Available CPUs'.timestamp
                        }
                        'Blob Stores'               = [pscustomobject]@{
                            Healthy   = $result.'Blob Stores'.healty
                            Message   = $result.'Blob Stores'.message
                            Error     = $result.'Blob Stores'.error
                            Details   = $result.'Blob Stores'.details
                            Time      = $result.'Blob Stores'.time
                            Duration  = $result.'Blob Stores'.duration
                            Timestamp = $result.'Blob Stores'.timestamp
                        }
                        'Default Admin Credentials' = [pscustomobject]@{
                            Healthy   = $result.'Default Admin Credentials'.healthy
                            Message   = $result.'Default Admin Credentials'.message
                            Error     = $result.'Default Admin Credentials'.error
                            Details   = $result.'Default Admin Credentials'.details
                            Time      = $result.'Default Admin Credentials'.time
                            Duration  = $result.'Default Admin Credentials'.duration
                            Timestamp = $result.'Default Admin Credentials'.timestamp
                        }
                        DefaultRoleRealm            = [pscustomobject]@{
                            Healthy   = $result.DefaultRoleRealm.healthy
                            Message   = $result.DefaultRoleRealm.message
                            Error     = $result.DefaultRoleRealm.error
                            Details   = $result.DefaultRoleRealm.details
                            Time      = $result.DefaultRoleRealm.time
                            Duration  = $result.DefaultRoleRealm.duration
                            Timestamp = $result.DefaultRoleRealm.timestamp
                        }
                        'File Blob Stores Path'     = [pscustomobject]@{
                            Healthy   = $result.'File Blob Stores Path'.healthy
                            Message   = $result.'File Blob Stores Path'.message
                            Error     = $result.'File Blob Stores Path'.error
                            Details   = $result.'File Blob Stores Path'.details
                            Time      = $result.'File Blob Stores Path'.time
                            Duration  = $result.'File Blob Stores Path'.duration
                            Timestamp = $result.'File Blob Stores Path'.timestamp
                        }
                        'File Descriptors'          = [pscustomobject]@{
                            Healthy   = $result.'File Descriptors'.healthy
                            Message   = $result.'File Descriptors'.message
                            Error     = $result.'File Descriptors'.error
                            Details   = $result.'File Descriptors'.details
                            Time      = $result.'File Descriptors'.time
                            Duration  = $result.'File Descriptors'.duration
                            Timestamp = $result.'File Descriptors'.timestamp
                        }
                        'Lifecycle Phase'           = [pscustomobject]@{
                            Healthy   = $result.'Lifecycle Phase'.healthy
                            Message   = $result.'Lifecycle Phase'.message
                            Error     = $result.'Lifecycle Phase'.error
                            Details   = $result.'Lifecycle Phase'.details
                            Time      = $result.'Lifecycle Phase'.time
                            Duration  = $result.'Lifecycle Phase'.duration
                            Timestamp = $result.'Lifecycle Phase'.timestamp
                        }
                        'Read-Only Detector'        = [pscustomobject]@{
                            Healthy   = $result.'Read-Only Detector'.healthy
                            Message   = $result.'Read-Only Detector'.message
                            Error     = $result.'Read-Only Detector'.error
                            Details   = $result.'Read-Only Detector'.details
                            Time      = $result.'Read-Only Detector'.time
                            Duration  = $result.'Read-Only Detector'.duration
                            Timestamp = $result.'Read-Only Detector'.timestamp
                        }
                        Scheduler                   = [pscustomobject]@{
                            Healthy   = $result.Scheduler.healthy
                            Message   = $result.Scheduler.message
                            Error     = $result.Scheduler.error
                            Details   = $result.Scheduler.details
                            Time      = $result.Scheduler.time
                            Duration  = $result.Scheduler.duration
                            Timestamp = $result.Scheduler.timestamp
                        }
                        'Thread Deadlock Detector'  = [pscustomobject]@{
                            Healthy   = $result.'Thread Deadlock Detector'.healthy
                            Message   = $result.'Thread Deadlock Detector'.message
                            Error     = $result.'Thread Deadlock Detector'.error
                            Details   = $result.'Thread Deadlock Detector'.details
                            Time      = $result.'Thread Deadlock Detector'.time
                            Duration  = $result.'Thread Deadlock Detector'.duration
                            Timestamp = $result.'Thread Deadlock Detector'.timestamp
                        }
                        Transactions                = [pscustomobject]@{
                            Healthy   = $result.Transactions.healthy
                            Message   = $result.Transactions.message
                            Error     = $result.Transactions.error
                            Details   = $result.Transactions.details
                            Time      = $result.Transactions.time
                            Duration  = $result.Transactions.duration
                            Timestamp = $result.Transactions.timestamp
                        }
                    }
                
                }
                catch {
                    $_.Exception.Message
                }
            }

        }
    }
}