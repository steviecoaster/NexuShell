function Disable-NexusRealm {
    <#
    .SYNOPSIS
    Disable realms in Nexus
    
    .DESCRIPTION
    Disable realms in Nexus
    
    .PARAMETER Realm
    The realms you wish to activate
    
    .EXAMPLE
    Disable-NexusRealm -Realm 'NuGet Api-Key Realm', 'Rut Auth Realm'

    .EXAMPLE
    Disable-NexusRealm -Realm 'LDAP Realm'
    
    .NOTES
    #>
    [CmdletBinding(HelpUri = 'https://github.com/steviecoaster/TreasureChest/blob/develop/docs/Disable-NexusRealm.md',SupportsShouldProcess,ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusRealm).name

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                }
                else {
                    $r
                }
            }
        )]
        [Alias('Name')]
        [String[]]
        $Realm,

        [Parameter()]
        [Switch]
        $Force
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/security/realms/active"

    }

    process {

        $body = @((Get-NexusRealm -Active| Where-Object { $_.Name -notin $Realm }).id)

        try {
           
            if ($Force -and -not $Confirm) {
                $ConfirmPreference = 'None'
                if ($PSCmdlet.ShouldProcess("$_", "Remove Repository")) {
                    Write-Verbose $($Body | ConvertTo-Json)
                    Invoke-Nexus -UriSlug $urislug -BodyAsArray $Body -Method PUT -ErrorAction Stop
                    
                }
            }
            else {
                if ($PSCmdlet.ShouldProcess("$_", "Remove Repository")) {
                    Write-Verbose $($Body | ConvertTo-Json)
                    Invoke-Nexus -UriSlug $urislug -BodyAsArray $Body -Method PUT -ErrorAction Stop
                }
            }
        }

        catch {
            $_.exception.message
        }

    }
}