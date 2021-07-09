function Start-NexusTask {
    <#
    .SYNOPSIS
    Starts a Nexus Task
    
    .DESCRIPTION
    Starts a Nexus Task
    
    .PARAMETER Task
    The task to start
    
    .EXAMPLE
    Stop-NexusTask -Task 'Cleanup Service'
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri = 'https://steviecoaster.dev/NexuShell/Tasks/Start-NexusTask/')]
    Param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusTask).Name

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                }

                else {
                    $r
                }
            })]
        [Alias('Name')]
        [String]
        $Task
    )

    process {

        $id = (Get-NexusTask | Where-Object { $_.Name -eq $Task }).Id
        $urislug = "/service/rest/v1/tasks/$id/run"
        Invoke-Nexus -Urislug $urislug -Method POST
    }
}