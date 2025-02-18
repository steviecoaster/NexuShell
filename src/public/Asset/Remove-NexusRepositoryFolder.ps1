function Remove-NexusRepositoryFolder {
    <#
    .SYNOPSIS
    Removes a given folder from a repository from the Nexus instance

    .PARAMETER RepositoryName
    The repository to remove from

    .PARAMETER Name
    The name of the folder to remove

    .EXAMPLE
    Remove-NexusRepositoryFolder -RepositoryName MyNuGetRepo -Name 'v3'
    # Removes the v3 folder in the MyNuGetRepo repository
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$RepositoryName,

        [Parameter(Mandatory)]
        [string]$Name
    )
    end {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $ApiParameters = @{
            UriSlug = "/service/extdirect"
            Method  = "POST"
            Body    = @{
                action = "coreui_Component"
                method =  "deleteFolder"
                data   = @(
                    $Name,
                    $RepositoryName
                )
                type   = "rpc"
                tid    = Get-Random -Minimum 1 -Maximum 100
            }
            Headers = @{
                "X-Nexus-UI" = "true"
            }
        }

        $Result = Invoke-Nexus @ApiParameters

        if (-not $Result.result.success) {
            throw "Failed to delete folder: $($Result.result.message)"
        }
    }
}