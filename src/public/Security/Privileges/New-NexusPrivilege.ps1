function New-NexusPrivilege {
    <#
    .SYNOPSIS

    Creates a new Nexus privilege which can be assigned to Roles
    
    .DESCRIPTION

    Creates a new Nexus privilege which can be assigned to Roles
    
    .PARAMETER Type

    Privilege type to create
    
    .PARAMETER Name

    The name of the privilege. This value cannot be changed.
    
    .PARAMETER Description

    Brief description for the new privilege
    
    .PARAMETER Action

    A collection of actions to associate with the privilege, using BREAD syntax (browse,read,edit,add,delete,all) as well as 'run' for script privileges.
    
    .PARAMETER Repository

    The name of the repository this privilege will grant access to (or * for all).
    
    .PARAMETER Format

    The repository format (i.e 'nuget', 'npm') this privilege will grant access to (or * for all).
    
    .PARAMETER ScriptName

    The name of a script to give access to.
    
    .PARAMETER Domain

    The domain (i.e. 'blobstores', 'capabilities' or even '*' for all) that this privilege is granting access to. Note that creating new privileges with a domain is only necessary when using plugins that define their own domain(s).
    
    .PARAMETER ContentSelector

    Name of a ContentSelector for Content Selector privilege type
    
    .PARAMETER WildcardPattern

    A colon separated list of parts that create a permission string.
    
    .EXAMPLE

    $params = @{
        Type = 'Application'
        Name = 'ApplicationPrivilegeExample'
        Description = 'Briefly describe the privilege'
        Action = 'Browse,Edit'
        Domain = 'blobstores''
    }

    New-NexusPrivilege @params

    .EXAMPLE

        $params = @{
        Type = 'Repository-Admin'
        Name = 'RepositoryAdminPrivilegeExample'
        Description = 'Briefly describe the privilege'
        Action = 'Browse,Edit'
        Format = 'npm'
        Repository = 'npmWebDevRepo'
    }

    New-NexusPrivilege @params

    .EXAMPLE

        $params = @{
        Type = 'Repository-Content-Selector'
        Name = 'RepoContentSelectorPrivilegeExample'
        Description = 'Briefly describe the privilege'
        Action = 'Browse,Edit'
        Format = 'nuget'
        Repository = 'NuGetProductionRepo'
        ContentSelector = 'LargeNupkgContent'
    }

    New-NexusPrivilege @params

    .EXAMPLE

        $params = @{
        Type = 'Repository-View'
        Name = 'RepoViewPrivilegeExample'
        Description = 'Briefly describe the privilege'
        Action = 'Browse,Edit'
        Format = 'nuget'
        Repostiory = 'NuGetProductionRepo'
    }

    New-NexusPrivilege @params

    .EXAMPLE

        $params = @{
        Type = 'Script'
        Name = 'ScriptPrivilegeExample'
        Description = 'Briefly describe the privilege'
        Action = 'Browse','Read','Edit'
        ScriptName = 'GroovySurfaceApiKeyDetails'
        
    }

    New-NexusPrivilege @params

    .EXAMPLE
    
        $params = @{
        Type = 'Wildcard'
        Name = 'WildcardPrivilegeExample'
        Description = 'Briefly describe the privilege'
        WildcardPattern = 'nuget:npm:*'
    }

    New-NexusPrivilege @params

    .NOTES

    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    Param(
        [Parameter(Mandatory,ParameterSetName="Default")]
        [Parameter(Mandatory,ParameterSetName="Repo")]
        [Parameter(Mandatory,ParameterSetName="Application")]
        [Parameter(Mandatory,ParameterSetName="Script")]
        [Parameter(Mandatory,ParameterSetName="Content")]
        [Parameter(Mandatory,ParameterSetname="Wildcard")]
        [ValidateSet('Application','Repository-Admin','Repository-Content-Selector','Repository-View','Script','Wildcard')]
        [String]
        $Type,

        [Parameter(Mandatory,ParameterSetName="Default")]
        [Parameter(Mandatory,ParameterSetName="Repo")]
        [Parameter(Mandatory,ParameterSetName="Script")]
        [String]
        $Name,

        [Parameter(Mandatory,ParameterSetName="Repo")]
        [Parameter(Mandatory,ParameterSetName="Script")]
        [String]
        $Description,

        [Parameter(Mandatory,ParameterSetName="Repo")]
        [Parameter(Mandatory,ParameterSetName="Script")]
        [ValidateSet('Read','Browse','Edit','Add','Delete','Run','Associate','Disassociate','All')]
        [String[]]
        $Action,

        [Parameter(Mandatory,ParameterSetName="Repo")]
        [ArgumentCompleter({
            param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

            $r = (Get-NexusRepository).Name

            if($WordToComplete){
                $r.Where($_ -match "^$WordToComplete")
            }
            else {
                $r
            }
        })]
        [String]
        $Repository,

        [Parameter(Mandatory,ParameterSetName="Repo")]
        [String]
        $Format,

        [Parameter(Mandatory,ParameterSetName="Script")]
        [String]
        $ScriptName,

        [Parameter(Mandatory,ParameterSetName="Application")]
        [String]
        $Domain,
        
        [Parameter(Mandatory,ParameterSetName="Content")]
        [String]
        $ContentSelector,

        [Parameter(Mandatory,ParameterSetname="Wildcard")]
        [String]
        $WildcardPattern
    )

    begin {
        if (-not $header) {
            throw "Not connected to Nexus server! Run Connect-NexusServer first."
        }
    }
    
    process {
        switch($Type){
            'Application' {
                $urislug = "/service/rest/v1/security/privileges/$($Type.ToLower())"

                $Body = @{
                    name = $Name
                    description = $Description
                    actions = @($Action)
                    domain = $Domain
                }

            }
            'Repository-Admin' {
                $urislug = "/service/rest/v1/security/privileges/$($Type.ToLower())"

                $Body = @{
                    name = $Name
                    description = $Description
                    actions = @($Action)
                    format = $Format
                    repository = $Repository
                }

            }
            'Repository-Content-Selector' {
                $urislug = "/service/rest/v1/security/privileges/$($Type.ToLower())"

                $Body = @{
                    name = $Name
                    description = $Description
                    actions = @($Action)
                    format = $Format
                    repository = $Repository
                    contentSelector = $ContentSelector
                }

            }
            'Repository-View' {
                $urislug = "/service/rest/v1/security/privileges/$($Type.ToLower())"

                $Body = @{
                    name = $Name
                    description = $Description
                    actions = @($Action)
                    format = $Format
                    repository = $Repository
                }

            }
            'Script' {
                $urislug = "/service/rest/v1/security/privileges/$($Type.ToLower())"

                $Body = @{
                    name = $Name
                    description = $Description
                    actions = @($Action)
                    scriptName = $ScriptName
                }
            }
            'Wildcard' {
                $urislug = "/service/rest/v1/security/privileges/$($Type.ToLower())"

                $Body = @{
                    name = $Name
                    description = $Description
                    pattern = $WildcardPattern
                }
            }   
        }

        Write-Verbose ($Body | ConvertTo-Json)
        Invoke-Nexus -Urislug $urislug -Body $Body -Method POST

    }
}