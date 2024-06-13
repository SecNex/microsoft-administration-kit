<#
.SYNOPSIS
    This script will connect to Microsoft Graph API.
.DESCRIPTION
    This script will connect to Microsoft Graph API.
.PARAMETER ClientId
    The client ID.
.PARAMETER ClientSecret
    The client secret.
.PARAMETER TenantId
    The tenant ID.
.EXAMPLE
    .\entra-connect.ps1 -ClientId "00000000-0000-0000-0000-000000000000" -ClientSecret "xxxxxxxx" -TenantId "00000000-0000-0000-0000-000000000000"
.NOTES
    File Name      : entra-connect.ps1
    Author:        : SecNex Community
    Prerequisite   : PowerShell 7.1.3
#>
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