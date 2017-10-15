# Scheduled Virtual Machine Shutdown/Startup - Microsoft Azure
Scheduled VM shutdown and startup runbook for Azure Automation

This is a development version. Tested and released versions will be available with install and configuration documentation here:

https://automys.com/library/asset/scheduled-virtual-machine-shutdown-startup-microsoft-azure

To contribute, please get in touch via email or a pull request!

Requirements:
- Azure Automation Account with contained script in a runbook
- Automation Account Variable Asset with the name “Default Azure Subscription” and your Subscription ID as value
- Tags with name “AutoShutdownSchedule” and value such as: “11PM -> 7AM, Saturday, Sunday”
