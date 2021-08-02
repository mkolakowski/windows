# turns off hibernation
	powercfg.exe /h off


# turns off sleep
	powercfg.exe -x -monitor-timeout-ac 0
	powercfg.exe -x -monitor-timeout-dc 0
	powercfg.exe -x -disk-timeout-ac 0
	powercfg.exe -x -disk-timeout-dc 0
	powercfg.exe -x -standby-timeout-ac 0
	powercfg.exe -x -standby-timeout-dc 0
	powercfg.exe -x -hibernate-timeout-ac 0
	powercfg.exe -x -hibernate-timeout-dc 0


# Disables Internet Explore Enhanced Security

    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green

# Disable UAC
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000
    Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green    

# Install Google Chrome
	Write-Host "Installing Google Chrome." -ForegroundColor Green
	$Path = $env:TEMP; 
	$Installer = "chrome_installer.exe"
	Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
	Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
	Remove-Item $Path\$Installer
