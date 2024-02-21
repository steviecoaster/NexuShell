function Set-NexusUserPassword {
    <#
    .SYNOPSIS
    Change a user's password.

    .DESCRIPTION
    Change a user's password.

    .PARAMETER Username
    The userid the request should apply to

    .PARAMETER NewPassword
    The new password to use.

    .EXAMPLE
    Set-NexusUserPassword -Username jimmy -NewPassword ("Sausage2021" | ConvertTo-SecureString -AsPlainText -Force)

    .NOTES

    #>
    [CmdletBinding(HelpUri='https://nexushell.dev/Security/User/Set-NexusUserPassword/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Username,

        [Parameter(Mandatory)]
        [SecureString]
        $NewPassword
    )

    process {
        $urislug = "/service/rest/v1/security/users/$Username/change-password"

        Invoke-Nexus -Urislug $urislug -BodyAsSecureString $NewPassword -Method PUT -ContentType 'text/plain'
    }
}