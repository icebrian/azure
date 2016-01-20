# Exec by running only "Say-Hello-To -Name "Istvan Cebrian"
#
workflow Say-Hello-To {
	param(
			[string] $Name
	)
	
	Write-Output ("Hello " + $Name)
}