function Set-NexusRole {
    <#
    .SYNOPSIS
    Modifies an existing Nexus Role
    
    .DESCRIPTION
    Modifies an existing Nexus Role
    
    .PARAMETER Role
    The role to modify
    
    .PARAMETER Name
    The new name of the role
    
    .PARAMETER Description
    Update the description
    
    .PARAMETER Privileges
    Update privileges
    
    .PARAMETER Roles
    Update nested roles
    
    .EXAMPLE
    Set-NexusRole -Role Example -Description "This is an updated description"
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/TreasureChest/Security/Roles/Set-NexusRole/')]
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter( {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $r = (Get-NexusRole).id

                if ($WordToComplete) {
                    $r.Where($_ -match "^$WordToComplete")
                }

                else {
                    $r
                }
            })]
        [String]
        $Role,

        [Parameter()]
        [String]
        $Name = $Role,

        [Parameter()]
        [String]
        $Description,

        [Parameter()]
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

        $Id = $Role

        $urislug = "/service/rest/v1/security/roles/$Id"

        $CurrentSetting = Get-NexusRole -Role $Role


        if (-not $Name) {
            $Name = $Role
        }

        $Privileges = if (-not $Privileges) {
            @($($CurrentSetting.privileges))
        }
        else { @($Privileges) }

        $Roles = if (-not $Roles -eq $null) {
            if ($null -ne $($CurrentSetting.roles)) {
                $null
            }
        }
        else { @($Roles) }

        $Body = @{
            
            id          = $Id
            name        = $Name
            description = $Description
            privileges  = $Privileges
            roles       = $Roles
            
        }

        Write-Verbose ($Body | ConvertTo-Json)

        Invoke-Nexus -Urislug $urislug -Body $Body -Method PUT 

    }
}