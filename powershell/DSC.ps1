
# Repositories: Chocolatey + PowerShell Gallery

# Find all Modules
Find-Module

# Find all DSC Resources (x = experimental, c = community, 
Find-DscResource

# Count all DSC Resources
Find-DscResource -ov r | measure

# Grid View of contents of var $r
$r | ogv

################################################################## mva START
# Find all MSFT Virtual Academy modules and pipe to install
Find-Module mva* |Install-Module
#Find-Module mva* |Remove-Module

# Verify installation with
gmo -ListAvailable mva*

# Load examples
Show-MVA_DSC_Examples -Day 1 -Module 3
################################################################## mva END

Get-Help *-DSC*
Get-Help *localConfig*
Get-DscLocalConfigurationManager -CimSession s1

# Get DSC Resources
Get-DscResource
Get-DscResource -Name WindowsFeature | Select-Object -ExpandProperty properties
Get-DscResource -Name WindowsFeature -Syntax

# Get Windows Feature and Pipe to Out Grid View
Get-WindowsOptionalFeature -Online | ogv
