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

### PowerShell Module

To use the MAK, you will need to import the module into your PowerShell session:

```powershell
Import-Module SecNex.MAK
```

You can then use the cmdlets provided by the MAK to manage your Microsoft products and services.

### Pipelines

The MAK includes a set of Azure DevOps pipelines and GitHub Actions workflows that you can use to automate the deployment and management of your Microsoft products and services.

To use the pipelines and workflows, you will need to create a new pipeline or workflow in your Azure DevOps project or GitHub repository and reference the appropriate YAML file in the MAK repository.

Best practices for pipelines and worjflows can be found in the [Best Practices for CI/CD](https://github.com/SecNex/bestpractice-cicd) repository.

## Contributing

If you would like to contribute to the MAK, please fork the repository and submit a pull request with your changes. You can also open an issue if you have any questions or suggestions.

## License

The MAK is released under the [MIT License](LICENSE).

## Contact

If you have any questions or feedback, please contact us at [support@secnex.io](mailto:support@secnex.io).
