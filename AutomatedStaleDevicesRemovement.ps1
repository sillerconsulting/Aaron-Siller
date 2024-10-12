$dt = (Get-Date).AddDays(-90)
$params = @{
	accountEnabled = $false
}

$Devices = Get-MgDevice -All | Where {$_.ApproximateLastSignInDateTime -le $dt}
foreach ($Device in $Devices) { 
   Update-MgDevice -DeviceId $Device.Id -BodyParameter $params 
}

$dt = (Get-Date).AddDays(-120)
$Devices = Get-MgDevice -All | Where {($_.ApproximateLastSignInDateTime -le $dt) -and ($_.AccountEnabled -eq $false)}
foreach ($Device in $Devices) {
   Remove-MgDevice -DeviceId $Device.Id
}

