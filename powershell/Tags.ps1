
# Login
Login-AzureRmAccount

# Select Subscription
Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

# Get Tags for specific RG
(Get-AzureRmResourceGroup -Name emailrelay).Tags

# Find RG's with specific Tag
(Find-AzureRmResourceGroup -Tag @{ RG="emailrelay" }).Name

# Find Resource with specific Tag
(Find-AzureRmResource -TagName Environment -TagValue TEST).Name

# Add Tag to RG removing existing Tags
Set-AzureRmResourceGroup -Name emailrelay -Tag @{ Dept="IT"; Environment="Test" }

# Add Tags to RG retaining existing Tags
$tags = (Get-AzureRmResourceGroup -Name emailrelay).Tags
$tags += @{Status="Approved"}
Set-AzureRmResourceGroup -Tag $tags -Name emailrelay

# Add Tags to a Resource removing existing Tags
$r = Get-AzureRmResource -ResourceName icwebfe-ip -ResourceGroupName emailrelay
Set-AzureRmResource -Tag @{ Dept="IT"; Environment="Test" } -ResourceId $r.ResourceId -Force

# Add Tags to a Resource retaining existing Tags
$r = Get-AzureRmResource -ResourceName icwebfe-ip -ResourceGroupName emailrelay
$r.tags += @{Status="Approved"}
Set-AzureRmResource -Tag $r.Tags -ResourceId $r.ResourceId -Force

# Apply all Tags from a RG to its Resources (Not retaining Existing Tags)
$groups = Get-AzureRmResourceGroup emailrelay
foreach ($g in $groups)
{
    Find-AzureRmResource -ResourceGroupNameEquals $g.ResourceGroupName | ForEach-Object {Set-AzureRmResource -ResourceId $_.ResourceId -Tag $g.Tags -Force }
}

# Apply all Tags from a RG to its Resources (Retaining Existing Tags)
$group = Get-AzureRmResourceGroup "emailrelay"
if ($group.Tags -ne $null) {
    $resources = $group | Find-AzureRmResource
    foreach ($r in $resources)
    {
        $resourcetags = (Get-AzureRmResource -ResourceId $r.ResourceId).Tags
        foreach ($key in $group.Tags.Keys)
        {
            if (($resourcetags) -AND ($resourcetags.ContainsKey($key))) { $resourcetags.Remove($key) }
        }
        $resourcetags += $group.Tags
        Set-AzureRmResource -Tag $resourcetags -ResourceId $r.ResourceId -Force
    }
}