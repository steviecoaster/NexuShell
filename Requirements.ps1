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

if (-not (Get-Command Install-RequiredModule -ErrorAction SilentlyContinue)) {
    Install-Script Install-RequiredModule -Force
}
Install-RequiredModule -Path $PSScriptRoot\RequiredModules.psd1