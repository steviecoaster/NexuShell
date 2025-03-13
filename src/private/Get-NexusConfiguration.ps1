function Get-NexusConfiguration {
    <#
    .SYNOPSIS
    Returns a list of settings configured in nexus.properties.

    .DESCRIPTION
    Retrieves the specified file (defaulting to the default install location) and returns each active setting.

    .PARAMETER Path
    The path to the properties file to return.

    .EXAMPLE
    Get-NexusConfiguration
    # Returns all properties and values

    .EXAMPLE
    (Get-NexusConfiguration).'application-port-ssl'
    # Returns the value for a single property, 'application-port-ssl'
    #>
    [CmdletBinding()]
    param(
        $Path = (Join-Path $script:InstalledNexusService.DataFolder "etc\nexus.properties")
    )
    Get-Content $Path | Where-Object {
        $_ -and $_ -notmatch "^\W*#"
    } | ConvertFrom-StringData
}