function Get-NexusTask {
    <#
    .SYNOPSIS
    Gets a list of Nexus tasks
    
    .DESCRIPTION
    Gets a list of Nexus tasks
    
    .PARAMETER Type
    The type of task to return
    
    .EXAMPLE
    Get-NexusTask

    .EXAMPLE
    Get-NexusTask -Type repository.cleanup
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri = 'https://nexushell.dev/Tasks/Get-NexusTask/')]
    Param(
        [Parameter()]
        [String[]]
        $Type
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {
        $urislug = '/service/rest/v1/tasks'
        if ($Type) {
            $Type | Foreach-Object {
                $urislug = '/service/rest/v1/tasks'
                $result = Invoke-Nexus -Urislug $urislug -BodyAsString $_ -Method Get

                $result.items | Foreach-Object {
                    [pscustomobject]@{
                        Id            = $_.id
                        Name          = $_.name
                        Type          = $_.type
                        Message       = $_.message
                        CurrentState  = $_.currentState
                        LastRunResult = $_.lastRunResult
                        NextRun       = $_.nextRun
                        LastRun       = $_.lastRun
                    }
                }            
            }
        }

        else {
            $result = Invoke-Nexus -Urislug $urislug -Method Get
            $result.items | Foreach-Object {
                [pscustomobject]@{
                    Id            = $_.id
                    Name          = $_.name
                    Type          = $_.type
                    Message       = $_.message
                    CurrentState  = $_.currentState
                    LastRunResult = $_.lastRunResult
                    NextRun       = $_.nextRun
                    LastRun       = $_.lastRun
                }
            }            
        }
    }
}
