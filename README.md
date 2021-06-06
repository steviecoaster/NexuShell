# TreasureChest

A PowerShell module for Sonatype Nexus repository server administration

## Try it out!

1. Clone this repo and run `.\build.ps1 -Build` from the cloned folder
2. Import the module with `Import-Module .\Output\TreasureChest\TreasureChest.psd1` from the cloned folder
3. Discover the available commands with `Get-Command -Module TreasureChest`
4. Explore the available commands with `Get-Help`
5. Start having fun!

### Currently supported functions

- Connect-NexusServer
- Get-NexusAnonymousAuthStatus
- Get-NexusBlobStore
- Get-NexusBlobStoreQuota
- Get-NexusLicenseStatus
- Get-NexusReadOnlyState
- Get-NexusRealm
- Get-NexusRepository
- Install-NexusLicense
- New-NexusAptHostedRepository
- New-NexusAptProxyRepository
- New-NexusBlobStore
- New-NexusNugetHostedRepository
- New-NexusNugetProxyRepository
- New-NexusRawGroupRepository
- New-NexusRawHostedRepository
- New-NexusBowerHostedRepository
- New-NexusBowerProxyRepository
- New-NexusBowerGroupRepository
- New-NexusCocoaPodProxyRepository
- New-NexusConanProxyRepository
- New-NexusCondaProxyRepository
- New-NexusDockerGroupRepository
- New-NexusDockerHostedRepository
- New-NexusDockerProxyRepository
- Remove-NexusBlobStore
- Remove-NexusRepository
- Set-NexusAnonymousAuth
- Set-NexusReadOnlyMode
