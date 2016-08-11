#Login-AzureRmAccount
#Get-AzureRmSubscription
#Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

### Source VHD (West US) - authenticated container ###
$srcUri = "https://lrstor0linstd.blob.core.windows.net/vhds/cos72a20164404313.vhd"

### Source Storage Account (West US) ###
$srcStorageAccount = "lrstor0linstd"
$srcStorageKey = "g7x4/PgLGNCjf2YVGJk68pl+CoQ4Lv9W7ukfs7+qoM/m1sOU6y1bet6zxhy8fsfuR/nEz9pZVQ7DB5IUR2du3g=="

### Target Storage Account (West US) ###
$destStorageAccount = "lrstor1linstd"
$destStorageKey = "knbyYqjvgLTHqed/Ck5ZwZZVPzTH0Z4UFsuiVtO/kUoYO0eXdIIPsIjFf1ro/4pnJRotKf7Y3LEza4uEwFDW1w=="

### Create the source storage account context ###
$srcContext = New-AzureStorageContext  –StorageAccountName $srcStorageAccount -StorageAccountKey $srcStorageKey

### Create the destination storage account context ###
$destContext = New-AzureStorageContext  –StorageAccountName $destStorageAccount -StorageAccountKey $destStorageKey

### Destination Container Name ###
$containerName = "copiedvhds"

### Create the container on the destination ###
New-AzureStorageContainer -Name $containerName -Context $destContext

### Start the asynchronous copy - specify the source authentication with -SrcContext ###
$blob1 = Start-AzureStorageBlobCopy -srcUri $srcUri -SrcContext $srcContext -DestContainer $containerName -DestBlob "testcopy1.vhd" -DestContext $destContext
