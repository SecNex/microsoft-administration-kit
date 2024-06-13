<#
.SYNOPSIS
    This script will managed groups in Entra ID environment.
.DESCRIPTION
    This script will managed groups in Entra ID environment.
.PARAMETER Environment
    The Power Platform environment name.
.PARAMETER Region
    The region of the environment.
.PARAMETER Stage
    The stage of the environment.
.PARAMETER GroupNamePrefix
    The prefix of the group name.
.EXAMPLE
    .\Groups.ps1 -Region "DE" -Environment "PP" -Stage "DEV"
    This will create a group with the name "R-PP-DE PP DEV".
.EXAMPLE
    .\Groups.ps1 -Region "DE" -Environment "PP" -Stage "DEV" -GroupNamePrefix "R-PP-"
    This will create a group with the name "R-PP-DE PP DEV".
.NOTES
    File Name      : Groups.ps1
    Author         : SecNex Community
    Prerequisite   : PowerShell 7.1.3
#>

param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("DE", "US", "CN", "EMEA", "AMER", "APAC")]
    [string]$Region,
    [Parameter(Mandatory = $true)]
    [string]$Environment,
    [Parameter(Mandatory = $true)]
    [switch]$DEV,
    [Parameter(Mandatory = $true)]
    [switch]$TST,
    [Parameter(Mandatory = $true)]
    [switch]$PRD,
    [Parameter(Mandatory = $false)]
    [string]$GroupNamePrefix = "R-PP-",
    [Parameter(Mandatory = $true)]
    [string]$TenantId,
    [Parameter(Mandatory = $true)]
    [string]$ClientId,
    [Parameter(Mandatory = $true)]
    [string]$ClientSecret
)

Write-Host $DEV
Write-Host $TST
Write-Host $PRD

$stages = @()

if ($DEV) {
    $stages += "DEV"
}
if ($TST) {
    $stages += "TST"
}
if ($PRD) {
    $stages += "PRD"
}

Write-Host $stages

# if (-not (Get-Module -Name Microsoft.Graph)) {
#     Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force -AllowClobber
# }

$roles = @("Users", "Makers", "Analysts")

function New-MicrosoftGraphLogin {
    param (
        [CmdletBinding()]
        [Parameter(Mandatory = $true)]
        [string]$ClientId,
        [Parameter(Mandatory = $true)]
        [string]$ClientSecret,
        [Parameter(Mandatory = $true)]
        [string]$TenantId
    )

    Write-Host "[INFO] Connecting to Microsoft Graph API..."
    $secpasswd = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
    $mycreds = New-Object System.Management.Automation.PSCredential ($ClientId, $secpasswd)
    Connect-MgGraph -TenantId $TenantId -ClientSecretCredential $mycreds -NoWelcome:$true
    Write-Host "[INFO] Connected to Microsoft Graph API!"
}

function New-PowerPlatformGroups {
    param (
        [CmdletBinding()]
        [Parameter(Mandatory = $true)]
        [string]$Region,
        [Parameter(Mandatory = $true)]
        [string]$Stage,
        [Parameter(Mandatory = $true)]
        [string]$Role,
        [Parameter(Mandatory = $true)]
        [string]$Prefix
    )

    $GroupName = "$Prefix$Region $Environment $Stage $Role"

    $searchGroup = Get-MgGroup -Filter "displayName eq '$GroupName'" -Top 1 -ErrorAction SilentlyContinue
    $searchCount = $searchGroup.Count
    if ($searchCount -eq 0) {
        Write-Host "[INFO] Creating group: $GroupName"
        $newGroup = New-MgGroup -DisplayName $GroupName -MailEnabled:$false -MailNickname "NotSet" -SecurityEnabled:$true
        Write-Host "[INFO] Group created with ID: $($newGroup.Id)"
        $groupObject = New-Object psobject -Property @{
            Id          = $newGroup.Id
            DisplayName = $newGroup.DisplayName
            Role        = $Role
            Region      = $Region
            Stage       = $Stage
        }
    }
    else {
        Write-Host "[INFO] Group already exists with ID: $($searchGroup.Id)"
        $groupObject = New-Object psobject -Property @{
            Id          = $searchGroup.Id
            DisplayName = $searchGroup.DisplayName
            Role        = $searchGroup.DisplayName.Split(" ")[-1]
            Region      = $searchGroup.DisplayName.Split(" ")[0].Split("-")[2]
            Stage       = $searchGroup.DisplayName.Split(" ")[2]
        }
    }

    return $groupObject
}

New-MicrosoftGraphLogin -ClientId $ClientId -ClientSecret $ClientSecret -TenantId $TenantId

$returnValue = @()
foreach ($stage in $stages) {
    Write-Host "[INFO] Processing stage: $stage"
    $stageRoles = @()
    $usersGroup = $null
    foreach ($role in $roles) {
        $stageRoles += New-PowerPlatformGroup -Region $Region -Stage "$stage" -Role "$role" -Prefix $GroupNamePrefix
        if ($role -eq "Users") {
            $usersGroup = $stageRoles[-1]
        }
    }
    Write-Host "[INFO] Assigning roles to Users group: $($usersGroup.Id)"
    New-MgGroupMember -GroupId $usersGroup.Id -DirectoryObjectId $_.Id -ErrorAction SilentlyContinue
    $returnValue += $stageRoles
}

# Filter out the groups:
# Role = Users

$filteredGroups = $returnValue | Where-Object { $_.Role -eq "Users" }
Write-Host "[INFO] Parent groups created:"
$devParentGroups = $filteredGroups | Where-Object { $_.Stage -eq "DEV" }
$tstParentGroups = $filteredGroups | Where-Object { $_.Stage -eq "TST" }
$prdParentGroups = $filteredGroups | Where-Object { $_.Stage -eq "PRD" }

Write-Host "##vso[task.setvariable variable=stageDevUsers;isOutput=true]$devParentGroups.Id"
Write-Host "##vso[task.setvariable variable=stageTstUsers;isOutput=true]$tstParentGroups.Id"
Write-Host "##vso[task.setvariable variable=stagePrdUsers;isOutput=true]$prdParentGroups.Id"

return $returnValue | Format-Table -AutoSize -Property Id, DisplayName, Role, Region, Stage