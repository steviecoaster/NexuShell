$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ModuleName = $env:ChocolateyPackageName  # this may be different from the package name and different case
$ModuleVersion = $env:ChocolateyPackageVersion  # this may change so keep this here
$SavedParamsPath = Join-Path $toolsDir -ChildPath 'parameters.saved'

if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Warning "$ModuleName has not been tested on this version of PowerShell"
}

# Module may already be installed outside of Chocolatey
Remove-Module -Name $ModuleName -Force -ErrorAction SilentlyContinue

# remove the saved parameters file if it exists
if (Test-Path -Path $savedParamsPath) {
    Remove-Item -Path $savedParamsPath -Force
}

$sourcePath = Join-Path $toolsDir -ChildPath "$($ModuleName).zip"
$destinationPath = @()

$PathSegment = @{
    Windows = "WindowsPowerShell\Modules\"
    Core    = "PowerShell\Modules\"

    AllUsers = $env:ProgramFiles
    CurrentUser = try {
        $PROFILE | Split-Path | Split-Path
    } catch {
        Write-Warning "Profile is set to '$($PROFILE)'. Current user '$($env:USERNAME)' may not be able to install at user level."
    }
}

$Parameters = Get-PackageParameters

if (-not $Parameters.ContainsKey('Windows') -and -not $Parameters.ContainsKey('Core')) {
    $Parameters += @{
        Windows = $PSVersionTable.PSVersion.Major -le 5
        Core    = $PSVersionTable.PSVersion.Major -gt 5
    }
}

if (-not $Parameters.ContainsKey('AllUsers') -and -not $Parameters.ContainsKey('CurrentUser')) {
    $Parameters += @{
        AllUsers    = Test-ProcessAdminRights
        CurrentUser = -not (Test-ProcessAdminRights)
    }
}

foreach ($Scope in $Parameters.Keys.Where{$Parameters[$_] -and $_ -in @("AllUsers", "CurrentUser")}) {
    if ($Parameters.Windows) {
        $destinationPath += Join-Path -Path $PathSegment.$Scope -ChildPath $PathSegment.Windows
    }

    if ($Parameters.Core) {
        $destinationPath += Join-Path -Path $PathSegment.$Scope -ChildPath $PathSegment.Core
    }
}

foreach ($destPath in $destinationPath) {
    Write-Verbose "Installing '$($modulename)' to '$($destPath)'."

    # Check if the destination path exists and create if not
    if (Test-Path -Path $destPath) {
        $null = New-Item -Path $destPath -ItemType Directory -Force
    }
    Get-ChocolateyUnzip -FileFullPath $sourcePath -Destination $destPath -PackageName $moduleName

    # save the locations where the module was installed so we can uninstall it
    Add-Content -Path $savedParamsPath -Value $destPath
}

# cleanup the module from the Chocolatey $toolsDir folder
Remove-Item -Path $sourcePath -Force -Recurse