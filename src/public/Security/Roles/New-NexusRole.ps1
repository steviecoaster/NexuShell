function New-NexusRole {
    <#
    .SYNOPSIS
    Creates a new Nexus Role
    
    .DESCRIPTION
    Creates a new Nexus Role
    
    .PARAMETER Id
    The ID of the role
    
    .PARAMETER Name
    The friendly name of the role
    
    .PARAMETER Description
    A description of the role
    
    .PARAMETER Privileges
    Included privileges for the role
    
    .PARAMETER Roles
    Included nested roles
    
    .EXAMPLE
    New-NexusRole -Id SamepleRole

    .EXAMPLE
    New-NexusRole -Id SampleRole -Description "A sample role" -Privileges nx-all
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Security/Roles/New-NexusRole/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Id,

        [Parameter(Mandatory)]
        [String]
        $Name,

        [Parameter()]
        [String]
        $Description,

        [Parameter(Mandatory)]
        [String[]]
        $Privileges,

        [Parameter()]
        [String[]]
        $Roles
    )

    begin {
        if (-not $header) { 
            throw 'Not connected to Nexus server! Run Connect-NexusServer first.' 
        } 
    }
    
    process {

        $urislug = '/service/rest/v1/security/roles'
        $Body = @{
            
            id          = $Id
            name        = $Name
            description = $Description
            privileges  = @($Privileges)
            roles       = $Roles
            
        }

        Invoke-Nexus -Urislug $urislug -Body $Body -Method POST | Foreach-Object {
            [PSCustomobject]@{
                Id = $_.id
                Name = $_.name
                Description = $_.description
                Privileges = $_.privileges
                Roles = $_.roles
            }
        }

    }
}