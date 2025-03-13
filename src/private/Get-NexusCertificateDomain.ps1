function Get-NexusCertificateDomain {
    <#
    .SYNOPSIS
    Returns the Certificate domain for the specified Nexus configuration, if present.

    .DESCRIPTION
    Uses the KeyTool to open the currently used KeyStore and grab the domain.

    .PARAMETER DataDir
    The path to the Sonatype Nexus data directory, e.g. C:\ProgramData\sonatype-work\nexus3.

    .PARAMETER ProgramDir
    The path to the Sonatype Nexus program files, e.g. C:\ProgramData\nexus.

    .EXAMPLE
    Get-NexusCertificateDomain -DataDir C:\ProgramData\sonatype-work\nexus3 -ProgramDir C:\ProgramData\nexus
    #>
    param(
        [string]$DataDir = $script:InstalledNexusService.DataFolder,
  
        [string]$ProgramDir = $script:InstalledNexusService.ProgramFolder
    )
    $Config = Get-NexusConfiguration -Path $DataDir\etc\nexus.properties
    if ($Config.'nexus-args'.Split(',') -contains '${jetty.etc}/jetty-https.xml') {
        [xml]$HttpsConfig = Get-Content $ProgramDir\etc\jetty\jetty-https.xml
        $KeyToolPath = Join-Path $ProgramDir "jre/bin/keytool.exe"
        $KeyStorePath = Join-Path (Join-Path $ProgramDir "etc/ssl") $HttpsConfig.SelectSingleNode("//Set[@name='KeyStorePath']").'#text'
        $KeyStorePassword = $HttpsConfig.SelectSingleNode("//Set[@name='KeyStorePassword']").'#text'
  
        if ((Test-Path $KeyToolPath) -and (Test-Path $KeyStorePath)) {
            # Running in a job, as otherwise KeyTool fails when run without input
            Start-Job {
                $KeyToolOutput = $using:KeyStorePassword | & "$using:KeyToolPath" -list -v -keystore "$using:KeyStorePath" -J"-Duser.language=en" 2>$null
                if ($KeyToolOutput -join "`n" -match "(?smi)Certificate\[1\]:\nOwner: CN=(?<Domain>.+?)(\n|,)") {
                    $Matches.Domain
                }
            } | Receive-Job -Wait
        }
    }
}