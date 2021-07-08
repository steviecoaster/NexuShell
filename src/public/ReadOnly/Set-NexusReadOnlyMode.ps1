function Set-NexusReadOnlyMode {
    <#
    .SYNOPSIS
    Sets the nexus instance Read-Only mode
    
    .DESCRIPTION
    Either Disable or Enable Read-Only mode of your nexus instance
    
    .PARAMETER Enable
    Sets the nexus instance to Read-Only mode
    
    .PARAMETER Disable
    Sets the nexus instance to write-enabled mode
    
    .EXAMPLE
    Set-NexusReadOnlyMode -Enable

    .EXAMPLE
    Set-NexusReadOnlyMode -Disable
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Set-NexusReadOnlyMode/',SupportsShouldProcess, DefaultParameterSetName = "Enable", ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory, ParameterSetName = "Enable")]
        [Switch]
        $Enable,

        [Parameter(Mandatory, ParameterSetName = "Disable")]
        [Switch]
        $Disable,

        [Parameter(ParameterSetName = "Disable")]
        [Switch]
        $Force

    )

    begin {

        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }

        $urislug = "/service/rest/v1/read-only"
    }

    process {
        
        switch ($PSCmdlet.ParameterSetName) {
            'Enable' {
                $Uri = $urislug + "/freeze"
                Invoke-Nexus -UriSlug $Uri -Method 'POST'
            }
            'Disable' {
                if ($Force -and -not $Confirm) {
                    $ConfirmPreference = 'None'
                    if ($PSCmdlet.ShouldProcess("Read-Only", "Forcibly release mode")) {
                        $Uri = $urislug + "/force-release"
                        Invoke-Nexus -UriSlug $Uri -Method 'POST'
        
                    }
                } 
    
                else {
                    Write-Warning "Caution! This operation could result in data loss"
                    if ($PSCmdlet.ShouldProcess("Read-Only", "Forcibly release mode")) {
                        $Uri = $urislug + "/release"
                        Invoke-Nexus -UriSlug $Uri -Method 'POST'
                    }
                }
            }
        }
    }
}