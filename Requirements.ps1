<#
    .Synopsis
        Installs prerequisites for building, testing, and publishing the module
#>
[CmdletBinding()]
param()

if (-not (Get-Command gitversion -ErrorAction SilentlyContinue)) {
    # We use GitVersion to generate the version based on history in source control
    choco install gitversion -y
}

if (-not ($Script = (Get-Command Install-RequiredModule -ErrorAction SilentlyContinue).Source)) {
    $Install = Install-Script Install-RequiredModule -Force -PassThru
    $Script = Join-Path $Install.InstalledLocation $Install.Name
}
& $Script -Path $PSScriptRoot\RequiredModules.psd1