function Get-NexusPrivilege {
    <#
    .SYNOPSIS
    Retrieve Privilege information from Nexus
    
    .DESCRIPTION
    Retrieve Privilege information from Nexus
    
    .PARAMETER PrivilegeId
    The id of the privilege to retrieve.
    
    .EXAMPLE
    Get-NexusPrivilege

    .EXAMPLE
    Get-NexusPrivilege -PrivilegeId NuGetProdAdmin
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Security/Privileges/Get-NexusPrivilege/')]
    Param(
        [Parameter()]
        [String]
        $PrivilegeId
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }

    process {


        if ($PrivilegeId) {
            $urislug = "/service/rest/v1/security/privileges/$PrivilegeId"

            try {
                $result = Invoke-Nexus -Urislug $urislug -Method GET

                [pscustomobject]@{
                    Name        = $result.name
                    Type        = $result.type
                    Description = $result.description
                    ReadOnly    = $result.readonly
                    Actions     = $result.actions
                    Domain      = $result.domain
                }
            }
            catch {
                $_.Exception.Message
            }
        }
        else {
            $urislug = '/service/rest/v1/security/privileges'

            $result = Invoke-Nexus -Urislug $urislug -Method GET

            $result | Foreach-Object {
                [pscustomobject]@{
                    Name        = $_.name
                    Type        = $_.type
                    Description = $_.description
                    ReadOnly    = $_.readOnly
                    Pattern     = $_.pattern
                }
            }
    
        }

    }
}