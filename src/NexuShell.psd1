#
# Module manifest for module 'NexuShell'
#
# Generated by: steviecoaster
#
# Generated on: 2/26/2021
#

@{
    RootModule        = 'NexuShell.psm1'
    Description       = 'Allows for the administration of Sonatype Nexus via its robust REST api'
    GUID              = '7e720347-1e77-4ba3-a848-1295093940c1'
    ModuleVersion     = '1.0'

    Author = 'steviecoaster'
    CompanyName = ''
    Copyright = '(c) 2021 steviecoaster. All rights reserved.'

    # Minimum version of the Windows PowerShell engine required by this module
    # PowerShellVersion = ''

    # For best performance, do not use wildcards and do not delete the entries, use an empty array.
    FunctionsToExport = @()
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @('Get-NexusLifecycle','New-NexusLifecycle')

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @("nexus", "repository", "REST", "API", "sonatype")

            # A URL to the license for this module.
            LicenseUri = 'https://raw.githubusercontent.com/steviecoaster/NexuShell/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/steviecoaster/NexuShell'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = ''

            # Prerelease string of this module
            Prerelease = ''

        } # End of PSData hashtable
    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    HelpInfoURI       = 'https://nexushell.dev/'
}
