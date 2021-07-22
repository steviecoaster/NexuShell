# NexuShell Changelog

## 1.0

Initial release

## 1.0.1 (21 July 2021)

### Bug Fixes

- #9 Set-NexusUserPassword reports "Unsupported Media Type"
- #8 Set-NexusUser requires parameters (some of which can't be supplied)
- #7 Get-NexusNuGetApiKey does not work with a user not authenticated through Connect-NexusServer
- Fixes parameter typo in ChocolateyInstall.ps1
- Switches to `Join-Path` for building zip archive path in ChocolateyInstall.ps1

### Maintenance

- Added a `-Force` Parameter to `Compress-Archive` in the build script to allow the choco package to be created locally without having to manually delete files.
- Adds logo to Project README