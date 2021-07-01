# TreasureChest Documentation

You've found the online documentation for [TreasureChest](https://github.com/steviecoaster/TreasureChest)!

TreasureChest is a PowerShell module for the [Sonatype Nexus Repository Server](https://www.sonatype.com/products/repository-oss) API. Each function inside of the module links back to its corresponding page here on the docs site.

## What is Sonatype Nexus

Sonatype Nexus is a Repository Server that exists in two flavors. Open Source (Sonatype Nexus OSS), and Pro (Sonatype Nexus Pro). The open-source version of Sonatype Nexus is extremely feature rich, providing you _almost_ all of the functionality of the Pro edition. It only lacks things like Azure Blob Storage availability for use in Blob Stores, High Availability, and Blob Store migrations, and a Support contract.

## Functionality

- Manage Repositories 🚧 WIP, partially implemented
- Manage Assets 🚧 Coming Soon!
- Manage Components 🚧 Coming Soon!
- Manage Anonymous Access
- Manage Licensing
- Manage Email configuration
- Manage Blob Stores
- Manage Routing Rules
- Manage Cleanup Policies 🚧 Coming Soon!
- Manage Scripts
- Manage Roles 🚧 Coming Soon!
- Manage Privileges
- Manage Users
- Manage Tasks
- Search Nexus 🚧 Coming Soon!
- Collect Support information

## Building

While in development there is no official module up on the PSGallery. If you'd like to take it for a spin while I'm working on it, follow these steps:

1. Clone this repo and run `.\build.ps1 -Build` from the cloned folder
2. Import the module with `Import-Module .\Output\TreasureChest\TreasureChest.psd1` from the cloned folder
3. Discover the available commands with `Get-Command -Module TreasureChest`
4. Explore the available commands with `Get-Help`
5. Start having fun!

Once I have complete API coverage I'll publish this to the Gallery, and from there you'll be able to do `Install-Module TreasureChest`, `Update-Module TreasureChest` etc
## Contributing

This is an Open Source project. If you spot a bug, or a feature that is missing file an [issue](https://github.com/steviecoaster/TreasureChest/issues/new)! You're also welcome to file a Pull Request with your changes. When filing issues please ensure to include as much information as possible to make troubleshooting easier. Things like Operating System, PowerShell Version, Nexus Version, and any error output you receive while running a command are extremely helpful.

Also, this is an open repository in which you encounter folks from many walks of life. Language is hard, but please try to keep conversations civil and inclusive. Foul language and extreme anger in comments will not be tolerated.