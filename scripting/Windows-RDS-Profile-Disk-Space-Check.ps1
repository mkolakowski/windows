# Modified from 
# https://www.cyberdrain.com/monitoring-with-powershell-monitoring-rds-upd-size/

#$DisksInWarning = @()

# Modify this vatiable to how much free space is needed
$PercentFree = 0.20

$VHDS = get-disk | Where-Object {$_.Location -match "VHD"}
foreach($VHD in $VHDS){
  #$FilePath = [io.path]::GetFileNameWithoutExtension("$($VHD.Location)")
  #$SIDObject = New-Object System.Security.Principal.SecurityIdentifier ($FilePath) 
  #$Username = $SIDObject.Translate([System.Security.Principal.NTAccount])
  $Volume = $VHD | Get-Partition | Get-Volume
  if($Volume.SizeRemaining -lt $volume.Size * $PercentFree ){ 
    $PercentFreeOut = $PercentFree * 100
    Write-Output "$($Username.Value) UPD Less than $PercentFreeOut% remaining. Path: $($VHD.Location)"
  }
}
