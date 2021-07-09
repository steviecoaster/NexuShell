function Get-NexusRealm {
    <#
    .SYNOPSIS
    Gets Nexus Realm information
    
    .DESCRIPTION
    Gets Nexus Realm information
    
    .PARAMETER Active
    Returns only active realms
    
    .EXAMPLE
    Get-NexusRealm

    .EXAMPLE
    Get-NexusRealm -Active
    #>
    [CmdletBinding(HelpUri = 'https://steviecoaster.dev/NexuShell/Get-NexusRealm/')]
    Param(
        [Parameter()]
        [Switch]
        $Active
    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        
        $urislug = "/service/rest/v1/security/realms/available"
        

    }

    process {

        if ($Active) {
            $current = Invoke-Nexus -UriSlug $urislug -Method 'GET'
            $urislug = '/service/rest/v1/security/realms/active'
            $Activated = Invoke-Nexus -UriSlug $urislug -Method 'GET'
            $current | Where-Object { $_.Id -in $Activated }
        }
        else {
            $result = Invoke-Nexus -UriSlug $urislug -Method 'GET' 

            $result | Foreach-Object {
                [pscustomobject]@{
                    Id   = $_.id
                    Name = $_.name
                }
            }
        }
    }
}