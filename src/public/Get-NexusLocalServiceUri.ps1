function Get-NexusLocalServiceUri {
    <#
    .SYNOPSIS
    Returns the base URI used to access Sonatype Nexus (and it's API)

    .DESCRIPTION
    Checks configuration files in order to find which schema, FQDN, port, and path Nexus is being run on, so that we can connect to it.

    .PARAMETER DataDir
    The path to the Sonatype Nexus data directory, e.g. C:\ProgramData\sonatype-work\nexus3.

    .PARAMETER ProgramDir
    The path to the Sonatype Nexus program files, e.g. C:\ProgramData\nexus.

    .PARAMETER ConfigPath
    The path to the in-use config file. Checks for the existance of nexus.properties, and falls back to nexus-default.properties if not present.

    .PARAMETER HostnameOverride
    If a wildcard certificate is used, or you want to specify a particular FQDN to access Nexus, you can override the attempted lookup with this parameter.

    .EXAMPLE
    Get-NexusLocalServiceUri

    .EXAMPLE
    Get-NexusLocalServiceUri -HostnameOverride nexus.fabrikam.com
    #>
    [CmdletBinding()]
    [Alias("Get-NexusUri")]
    param(
        [Parameter()]
        [string]$DataDir = $script:InstalledNexusService.DataFolder,
  
        [Parameter()]
        [string]$ProgramDir = $script:InstalledNexusService.ProgramFolder,
  
        [Parameter()]
        [string]$ConfigPath = $(
            if (Test-Path $DataDir/etc/nexus.properties) {
                "$DataDir/etc/nexus.properties"
            } elseif (Test-Path $ProgramDir/etc/nexus-default.properties) {
                "$ProgramDir/etc/nexus-default.properties"
            }
        ),

        [string]$HostnameOverride
    )
    $Scheme, $Hostname, $Port, $Path = if (Test-Path $ConfigPath) {
        $Config = Get-NexusConfiguration -Path $ConfigPath -ErrorAction SilentlyContinue
  
        if ($Config.'application-port-ssl' -gt 0) {
            'https'
            if ($CertDomain = Get-NexusCertificateDomain -ConfigPath $ConfigPath) {
                if (-not $script:OverriddenDomains) { $script:OverriddenDomains = @{} }
                if ($CertDomain -notmatch '^\*') {
                    $CertDomain
                } elseif ($CertDomain -match '^\*' -and $HostnameOverride -like $CertDomain) {
                    ($script:OverriddenDomains[$CertDomain] = $HostnameOverride)
                } elseif ($CertDomain -match '^\*') {
                    while ($script:OverriddenDomains[$CertDomain] -notlike $CertDomain) {
                        $script:OverriddenDomains[$CertDomain] = Read-Host "Please provide the FQDN for Nexus matching the '$($CertDomain)' certificate"
                    }
                    $script:OverriddenDomains[$CertDomain]
                }
            } else {
                Write-Warning "Could not figure out SSL configuration for $($env:ComputerName) - using 'localhost', specify -HostnameOverride if required."
                "localhost"
            }
            $Config.'application-port-ssl'
        } elseif ($Config.'application-port' -gt 0) {
            'http'
            if ($HostnameOverride) {
                $HostnameOverride
            } else {
                "localhost"
            }
            $Config.'application-port'
        } else {
            "http"
            "localhost"
            "8081"
        }
  
        $Config.'nexus-context-path'
    }
  
    # Set defaults if still not present
    if (-not $Hostname) { $Hostname = "localhost" }
    if (-not $Scheme) { $Scheme = 'http' }
    if (-not $Port) { $Port = '8081' }
  
    "$($Scheme)://$($Hostname):$($Port)$($Path)"
}