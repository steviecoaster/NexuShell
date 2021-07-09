function Set-NexusAnonymousAuth {
    <#
    .SYNOPSIS
    Turns Anonymous Authentication on or off in Nexus
    
    .DESCRIPTION
    Turns Anonymous Authentication on or off in Nexus
    
    .PARAMETER Enabled
    Turns on Anonymous Auth
    
    .PARAMETER Disabled
    Turns off Anonymous Auth
    
    .EXAMPLE
    Set-NexusAnonymousAuth -Enabled
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Set-NexusAnonymousAuth/')]
    Param(
        [Parameter()]
        [Switch]
        $Enabled,

        [Parameter()]
        [Switch]
        $Disabled
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/security/anonymous"
    }

    process {

        Switch($true){

            $Enabled {
                $Body = @{
                    enabled = $true
                    userId = 'anonymous'
                    realmName = 'NexusAuthorizingRealm'
                }

                Invoke-Nexus -UriSlug $urislug -Body $Body -Method 'PUT'
            }

            $Disabled {
                $Body = @{
                    enabled = $false
                    userId = 'anonymous'
                    realmName = 'NexusAuthorizingRealm'
                }

                Invoke-Nexus -UriSlug $urislug -Body $Body -Method 'PUT'

            }
        }
    }
}