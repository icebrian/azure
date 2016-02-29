
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
Show-MVA_DSC_Examples -Day 1 -Module 2
################################################################## mva END