$connectionName = "AzureRunAsConnection"
$SubId = Get-AutomationVariable -Name 'SubscriptionId'
try
{
   # Get the connection "AzureRunAsConnection "
   $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName

   "Logging in to Azure..."
   Add-AzureRmAccount `
     -ServicePrincipal `
     -TenantId $servicePrincipalConnection.TenantId `
     -ApplicationId $servicePrincipalConnection.ApplicationId `
     -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint
   "Setting context to a specific subscription"
   Set-AzureRmContext -SubscriptionId $SubId
}
catch {
    if (!$servicePrincipalConnection)
    {
       $ErrorMessage = "Connection $connectionName not found."
       throw $ErrorMessage
     } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
     }
}

<#
.SYNOPSIS
  Connects to Azure and stops all VMs (ASM and ARM) in the specified subscription.

.DESCRIPTION
  This runbook connects to Azure and stops all VMs (ASM and ARM) in the specified Azure subscription.
  You can attach a schedule to this runbook to run it at a specific time.
  This runbook uses cmdlets from the version 1.0.3 of Azure modules.

.PARAMETER AzureCredentialAssetName
   Optional with default of "AzureCredential".
   The name of an Automation credential asset that contains the Azure AD user credential with authorization for this subscription.
   To use an asset with a different name you can pass the asset name as a runbook input parameter or change the default value for the input parameter.

.PARAMETER AzureSubscriptionIdAssetName
   Optional with default of "AzureSubscriptionId".
   The name of An Automation variable asset that contains the GUID for this Azure subscription.
   To use an asset with a different name you can pass the asset name as a runbook input parameter or change the default value for the input parameter.

.NOTES
   REQUIRED: You need to update all your Azure modules to version 1.0.3 before running this runbook.
   LASTEDIT: February 24, 2016
#>

#param (
#   [Parameter(Mandatory=$false)]
#             [String]$AzureCredentialAssetName = $connectionName,

  #  [Parameter(Mandatory=$false)]
#             [String]$AzureSubscriptionIDAssetName = 'SubscriptionId'
#)
$AzureCredentialAssetName = $connectionName,
$AzureSubscriptionIDAssetName = 'SubscriptionId'

# Setting error and warning action preferences
$ErrorActionPreference = "SilentlyContinue"
$WarningPreference = "SilentlyContinue"

# Connecting to Azure
$Cred = Get-AutomationPSCredential -Name $AzureCredentialAssetName -ErrorAction Stop
$null = Add-AzureAccount -Credential $Cred -ErrorAction Stop -ErrorVariable err
$null = Add-AzureRmAccount -Credential $Cred -ErrorAction Stop -ErrorVariable err

# Selecting the subscription to work against
$SubID = Get-AutomationVariable -Name $AzureSubscriptionIDAssetName
Select-AzureRmSubscription -SubscriptionId $SubID

# Getting all resource groups
$ResourceGroups = (Get-AzureRmResourceGroup -ErrorAction Stop).ResourceGroupName

if ($ResourceGroups)
{
    foreach ($ResourceGroup in $ResourceGroups)
    {
        "`n$ResourceGroup"

        # Getting all virtual machines
        $RmVMs = (Get-AzureRmVM -ResourceGroupName $ResourceGroup -ErrorAction $ErrorActionPreference -WarningAction $WarningPreference).Name

        # Managing virtual machines deployed with the Resource Manager deployment model
        if ($RmVMs)
        {
            foreach ($RmVM in $RmVMs)
            {
                $RmPState = (Get-AzureRmVM -ResourceGroupName $ResourceGroup -Name $RmVM -Status -ErrorAction $ErrorActionPreference -WarningAction $WarningPreference).Statuses.Code[1]

                if ($RmPState -eq 'PowerState/deallocated')
                {
                    "`t$RmVM is already shut down."
                }
                else
                {
                    "`t$RmVM is shutting down ..."
                    $RmSState = (Stop-AzureRmVM -ResourceGroupName $ResourceGroup -Name $RmVM -Force -ErrorAction $ErrorActionPreference -WarningAction $WarningPreference).IsSuccessStatusCode

                    if ($RmSState -eq 'True')
                    {
                        "`t$RmVM has been shut down."
                    }
                    else
                    {
                        "`t$RmVM failed to shut down."
                    }
                }
            }
        }
        else
        {
            "`tNo VMs deployed with the Resource Manager deployment model."
        }

        # Managing virtual machines deployed with the classic deployment model
                              $VMs = (Get-AzureVM -ServiceName $ResourceGroup -ErrorAction $ErrorActionPreference -WarningAction $WarningPreference).Name

        if ($VMs)
        {
            foreach ($VM in $VMs)
            {
                $PState = (Get-AzureVM -ServiceName $ResourceGroup -Name $VM -ErrorAction $ErrorActionPreference -WarningAction $WarningPreference).PowerState

                if ($PState -eq 'Stopped')
                {
                    "`t$VM is already shut down."
                }
                else
                {
                    "`t$VM is shutting down ..."
                    $SState = (Stop-AzureVM -ServiceName $ResourceGroup -Name $VM -Force -ErrorAction $ErrorActionPreference -WarningAction $WarningPreference).OperationStatus

                    if ($SState -eq 'Succeeded')
                    {
                        "`t$VM has been shut down."
                    }
                    else
                    {
                        "`t$VM failed to shut down."
                    }
                }
            }
        }
        else
        {
            "`tNo VMs deployed with the classic deployment model."
        }
    }
}
else
{
    "`tNo resource group found."
}
