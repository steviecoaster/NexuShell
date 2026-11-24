function Get-NexusRepositoryServiceInstall {
    <#
    .SYNOPSIS
    If found, returns the name of the Nexus service and the install and data directories it uses.

    .DESCRIPTION
    Checks all current services for services that run "nexus.exe", then returns the program and data directories for one/each.

    .PARAMETER AllResults
    To speed up execution, by default we check services until we find the first one running nexus.exe.
    If you have more than one instance installed, you can use this switch to check all services.

    .EXAMPLE
    Get-NexusRepositoryInstallValues
    #>
    [CmdletBinding()]
    param(
        # By default, we assume there is only one service. This searches for all installed services.
        [switch]$AllResults
    )
    # If you have a lot of services, searching them all may take longer -
    # so we can stop searching when we find the first service matching nexus.exe.
    $ResultCount = @{}
    if (-not $AllResults) { $ResultCount.First = 1 }

    $NexusService = Get-ChildItem HKLM:\System\CurrentControlSet\Services\ | Where-Object {
      ($ImagePath = Get-ItemProperty -Path $_.PSPath -Name ImagePath -ErrorAction SilentlyContinue) -and
        $ImagePath.ImagePath.Trim('"''').Contains('\nexus.exe')
    } | Select-Object @ResultCount
  
    foreach ($Service in $NexusService) {
        $ServiceName = $Service.PSChildName
        $ImagePath = (Get-ItemProperty -LiteralPath $Service.PSPath).ImagePath
        $Executable = [regex]::Match(
            $ImagePath,
            '(?i)^\s*(?:"(?<Path>[^"]+\.exe)"|(?<Path>[^"]+?\.exe))(?=\s|$)'
        )

        if (-not $Executable.Success) {
            throw "Cannot parse the executable from ImagePath for service '$ServiceName': $ImagePath"
        }

        $BinFolder = Split-Path -LiteralPath $Executable.Groups['Path'].Value
        $TargetFolder = Split-Path -LiteralPath $BinFolder
        $DataFolder = Convert-Path (Join-Path $TargetFolder "$((Get-Content $TargetFolder\bin\nexus.vmoptions) -match '^-Dkaraf.data=(?<RelativePath>.+)$' -replace '^-Dkaraf.data=')")
        [PSCustomObject]@{
            ServiceName   = $ServiceName
            ProgramFolder = $TargetFolder
            DataFolder    = $DataFolder
        }
    }
}
