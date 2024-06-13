# (M)icrosoft (A)dministration (K)it

## Introduction

The Microsoft Administration Kit (MAK) is a collection of scripts and tools that help automate the deployment and management of Microsoft products and services. The MAK is designed to be used by IT professionals who are responsible for managing Microsoft products and services in an enterprise environment.

## Features

The MAK includes the following features:

- [ ] Power Platform
- [ ] Microsoft 365
    - [ ] Exchange Online
    - [ ] SharePoint Online
    - [ ] Teams
    - [ ] OneDrive
- [ ] Azure DevOps
- [ ] Azure
- [ ] Entra ID
- [ ] Windows Server
- [ ] Windows 10 / 11

## For your own projects...

- Identity Access Management
    - [Power Platform](powerplatform) (Power Apps, Power Automate, Power BI) 
- Backup and Recovery
- Monitoring and Reporting
- Security and Compliance
- Automation and Orchestration
- Deployment and Provisioning
- Virtualization
    - [Hyper-V](hyperv)
    - [Azure Virtual Machines](azurevirtualmachines)
- Containers
    - [Docker](docker)
    - [Kubernetes](kubernetes)
- Storage and File Services
    - [Azure Files](azurefiles)
    - [Azure Blob Storage](azureblobstorage)
    - [Azure Data Lake Storage](azuredatalakestorage)
- Networking
    - [Azure Virtual Network](azurevirtualnetwork)
    - [Azure ExpressRoute](azureexpressroute)
    - [Azure VPN Gateway](azurevpngateway)
- Configuration Management
    - [Azure Automation](azureautomation)
    - [Azure Configuration Management](azureconfigurationmanagement)
- Patch Management
    - [Windows Update](windowsupdate)
    - [Azure Update Management](azureupdatemanagement)
- Incident Response
- Disaster Recovery
- Change Management

## Installation

To use the MAK, you will need PowerShell 7.0 or later installed on your computer. You can download PowerShell 7.0 from the [PowerShell GitHub page](https://github.com/Microsoft/PowerShell).

After you can clone the repository:

```powershell
git clone https://github.com/SecNex/microsoft-administration-kit.git
```

Or install via NuGet:

```powershell
Install-Module -Name SecNex.MAK -Scope CurrentUser -AllowClobber -Force
```

## Usage

To use the MAK, you will need to import the module into your PowerShell session:

```powershell
Import-Module SecNex.MAK
```

You can then use the cmdlets provided by the MAK to manage your Microsoft products and services.