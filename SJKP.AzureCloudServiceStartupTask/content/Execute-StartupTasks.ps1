Import-Module WebAdministration
     
Get-childitem IIS:/AppPools/ |% {
     
	$ApplicationPoolName = $_.Name
	Write-host $ApplicationPoolName
    # Delete all existing recycle times
    Clear-ItemProperty IIS:\AppPools\$ApplicationPoolName -Name Recycling.periodicRestart.schedule     	

	$restartTime = "03:00"
    Write-Output "Adding recycle at $restartTime"
    # Set the application pool to restart at the time we want
    New-ItemProperty -Path "IIS:\AppPools\$ApplicationPoolName" -Name Recycling.periodicRestart.schedule -Value @{value=$restartTime}
 
	#Remove idle timeout	
    Set-ItemProperty -Path "IIS:\AppPools\$ApplicationPoolName" -Name processModel.idleTimeout -value ( [TimeSpan]::FromMinutes(0))

	#Remove recycling at regular time interval e.g. every 1740 minutes
	Set-ItemProperty -Path "IIS:\AppPools\$ApplicationPoolName" -Name recycling.periodicRestart.time -value ( [TimeSpan]::FromMinutes(0))
}