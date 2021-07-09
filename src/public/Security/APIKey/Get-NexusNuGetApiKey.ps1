function Get-NexusNuGetApiKey {
    <#
    .SYNOPSIS
    Retrieves the NuGet API key of the given user credential
    
    .DESCRIPTION
    Retrieves the NuGet API key of the given user credential
    
    .PARAMETER Credential
    The Nexus User whose API key you wish to retrieve
    
    .EXAMPLE
    Get-NexusNugetApiKey -Credential (Get-Credential)
    
    .NOTES
    
    #>
    [CmdletBinding(HelpUri='https://steviecoaster.dev/NexuShell/Security/API%20Key/Get-NexusNuGetApiKey/')]
    Param(
        [Parameter(Mandatory)]
        [PSCredential]
        $Credential
    )

    process {
        $token = Get-NexusUserToken -Credential $Credential
        $base64Token = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($token))
        $UriBase = "$($protocol)://$($Hostname):$($port)$($ContextPath)"
        
        $slug = "/service/rest/internal/nuget-api-key?authToken=$base64Token&_dc=$(([DateTime]::ParseExact("01/02/0001 21:08:29", "MM/dd/yyyy HH:mm:ss",$null)).Ticks)"

        $uri = $UriBase + $slug

        Invoke-RestMethod -Uri $uri -Method GET -ContentType 'application/json' -Headers $header -UseBasicParsing

    }
}