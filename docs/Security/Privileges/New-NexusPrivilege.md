---
external help file: NexuShell-help.xml
Module Name: NexuShell
online version:
schema: 2.0.0
---

# New-NexusPrivilege

## SYNOPSIS

Creates a new Nexus privilege which can be assigned to Roles

## SYNTAX

### Default (Default)

```powershell
New-NexusPrivilege -Type <String> -Name <String> [<CommonParameters>]
```

### Wildcard

```powershell
New-NexusPrivilege -Type <String> -WildcardPattern <String> [<CommonParameters>]
```

### Content

```powershell
New-NexusPrivilege -Type <String> -ContentSelector <String> [<CommonParameters>]
```

### Script

```powershell
New-NexusPrivilege -Type <String> -Name <String> -Description <String> -Action <String[]> -ScriptName <String>
 [<CommonParameters>]
```

### Application

```powershell
New-NexusPrivilege -Type <String> -Domain <String> [<CommonParameters>]
```

### Repo

```powershell
New-NexusPrivilege -Type <String> -Name <String> -Description <String> -Action <String[]> -Repository <String>
 -Format <String> [<CommonParameters>]
```

## DESCRIPTION

Creates a new Nexus privilege which can be assigned to Roles

## EXAMPLES

### EXAMPLE 1

```powershell
$params = @{
    Type = 'Application'
    Name = 'ApplicationPrivilegeExample'
    Description = 'Briefly describe the privilege'
    Action = 'Browse,Edit'
    Domain = 'blobstores''
}

New-NexusPrivilege @params
```

### EXAMPLE 2

```powershell
$params = @{
Type = 'Repository-Admin'
Name = 'RepositoryAdminPrivilegeExample'
Description = 'Briefly describe the privilege'
Action = 'Browse,Edit'
Format = 'npm'
Repository = 'npmWebDevRepo'
}

New-NexusPrivilege @params
```

### EXAMPLE 3

```powershell
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
```

### EXAMPLE 4

```powershell
$params = @{
Type = 'Repository-View'
Name = 'RepoViewPrivilegeExample'
Description = 'Briefly describe the privilege'
Action = 'Browse,Edit'
Format = 'nuget'
Repostiory = 'NuGetProductionRepo'
}

New-NexusPrivilege @params
```

### EXAMPLE 5

```powershell
$params = @{
Type = 'Script'
Name = 'ScriptPrivilegeExample'
Description = 'Briefly describe the privilege'
Action = 'Browse','Read','Edit'
ScriptName = 'GroovySurfaceApiKeyDetails'

}

New-NexusPrivilege @params
```

### EXAMPLE 6

```powershell
$params = @{
Type = 'Wildcard'
Name = 'WildcardPrivilegeExample'
Description = 'Briefly describe the privilege'
WildcardPattern = 'nuget:npm:*'
}

New-NexusPrivilege @params
```

## PARAMETERS

### -Type

Privilege type to create

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

The name of the privilege.
This value cannot be changed.

```yaml
Type: String
Parameter Sets: Default, Script, Repo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Brief description for the new privilege

```yaml
Type: String
Parameter Sets: Script, Repo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Action

A collection of actions to associate with the privilege, using BREAD syntax (browse,read,edit,add,delete,all) as well as 'run' for script privileges.

```yaml
Type: String[]
Parameter Sets: Script, Repo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repository

The name of the repository this privilege will grant access to (or * for all).

```yaml
Type: String
Parameter Sets: Repo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format

The repository format (i.e 'nuget', 'npm') this privilege will grant access to (or * for all).

```yaml
Type: String
Parameter Sets: Repo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptName

The name of a script to give access to.

```yaml
Type: String
Parameter Sets: Script
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain

The domain (i.e.
'blobstores', 'capabilities' or even '*' for all) that this privilege is granting access to.
Note that creating new privileges with a domain is only necessary when using plugins that define their own domain(s).

```yaml
Type: String
Parameter Sets: Application
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentSelector

Name of a ContentSelector for Content Selector privilege type

```yaml
Type: String
Parameter Sets: Content
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WildcardPattern

A colon separated list of parts that create a permission string.

```yaml
Type: String
Parameter Sets: Wildcard
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
