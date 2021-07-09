function Get-NexusRole {
    <#
    .SYNOPSIS
    Retrieve Nexus Role information
    
    .DESCRIPTION
    Retrieve Nexus Role information
    
    .PARAMETER Role
    The role to retrieve
    
    .PARAMETER Source
    The source to retrieve from
    
    .EXAMPLE
    Get-NexusRole

    .EXAMPLE
    Get-NexusRole -Role ExampleRole
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Security/Roles/Get-NexusRole/')]
    Param(
        [Parameter()]
        [Alias('id')]
        [String]
        $Role,

        [Parameter()]
        [String]
        $Source
    )
    begin { if (-not $header) { throw 'Not connected to Nexus server! Run Connect-NexusServer first.' } }
    process {
        
        $urislug = '/service/rest/v1/security/roles'

        if ($Role) {
            $urislug = "/service/rest/v1/security/roles/$Role"
        }

        if ($Source) {
            $urislug = "/service/rest/v1/security/roles?source=$Source"
        }

        if ($Role -and $Source) {
            $urislug = "/service/rest/v1/security/roles/$($Role)?source=$Source"
        }

        Write-verbose $urislug
        $result = Invoke-Nexus -Urislug $urislug -Method GET

        $result | ForEach-Object {
            [PSCustomObject]@{
                Id          = $_.id
                Source       = $_.source
                Name        = $_.name
                Description = $_.description
                Privileges  = $_.privileges
                Roles       = $_.roles
            }
        }
    }
}