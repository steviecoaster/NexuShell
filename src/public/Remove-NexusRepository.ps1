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
    [CmdletBinding(HelpUri = 'https://github.com/steviecoaster/TreasureChest/blob/develop/docs/Remove-NexusRepository.md', SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter({
            param($command,$WordToComplete,$CommandAst,$FakeBoundParams)
            $repositories = (Get-NexusRepository).Name

            if($WordToComplete){
                $repositories.Where{$_ -match "^$WordToComplete"}
            } else {
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
        $Uri = $urislug + "/$Repository"

        try {
           
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$Repository", "Remove Repository")) {
                    $result = Invoke-Nexus -UriSlug $Uri -Method 'DELETE' -ErrorAction Stop
                    [pscustomobject]@{
                        Status     = 'Success'
                        Repository = $Repository     
                    }
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$Repository", "Remove Repository")) {
                    $result = Invoke-Nexus -UriSlug $Uri -Method 'DELETE' -ErrorAction Stop
                    [pscustomobject]@{
                        Status     = 'Success'
                        Repository = $Repository
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