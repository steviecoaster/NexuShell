Function Get-NexusUserSource {
<#
.SYNOPSIS
Retrieve a list of available user sources

.DESCRIPTION
Retrieve a list of available user sources. These sources are things that can handle authentication to Nexus

.EXAMPLE
Get-NexusUserSource

.NOTES

#>
[CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Security/User%20Sources/Get-NexusUserSource/')]
Param()
    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

    }

    process {
        $urislug = '/service/rest/v1/security/user-sources'

        $result = Invoke-Nexus -Urislug $urislug -Method GET

        $result | ForEach-Object {
            [pscustomobject]@{
                Id = $_.id
                Name = $_.Name
            }
        }
    }
}