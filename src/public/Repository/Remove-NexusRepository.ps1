function Remove-NexusRepository {
    <#
    .SYNOPSIS
    Removes a given repository from the Nexus instance
    
    .DESCRIPTION
    Removes a given repository from the Nexus instance
    
    .PARAMETER Repository
    The repository to remove
    
    .PARAMETER Force
    Disable prompt for confirmation before removal
    
    .EXAMPLE
    Remove-NexusRepository -Repository ProdNuGet

    .EXAMPLE
    Remove-NexusRepository -Repository MavenReleases -Force()
    #>
    [CmdletBinding(HelpUri = 'https://steviecoaster.github.io/NexuShell/Remove-NexusRepository/', SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [ArgumentCompleter( {
                param($CommandName, $ParameterName, $WordToComplete, $CommandAst, $FakeBoundParameters)
                $repositories = (Get-NexusRepository).Name

                if ($WordToComplete) {
                    $repositories.Where{ $_ -match "^$WordToComplete" }
                }
                else {
                    $repositories
                }
            })]
        [String[]]
        $Repository,

        [Parameter()]
        [Switch]
        $Force
    )
    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/repositories"
    }
    process {

        $Repository | Foreach-Object {
            $Uri = $urislug + "/$_"

            try {
           
                if ($Force -and -not $Confirm) {
                    $ConfirmPreference = 'None'
                    if ($PSCmdlet.ShouldProcess("$_", "Remove Repository")) {
                        $result = Invoke-Nexus -UriSlug $Uri -Method 'DELETE' -ErrorAction Stop
                        [pscustomobject]@{
                            Status     = 'Success'
                            Repository = $_     
                        }
                    }
                }
                else {
                    if ($PSCmdlet.ShouldProcess("$_", "Remove Repository")) {
                        $result = Invoke-Nexus -UriSlug $Uri -Method 'DELETE' -ErrorAction Stop
                        [pscustomobject]@{
                            Status     = 'Success'
                            Repository = $_
                            Timestamp  = $result.date
                        }
                    }
                }
            }

            catch {
                $_.exception.message
            }
        }
    }
}