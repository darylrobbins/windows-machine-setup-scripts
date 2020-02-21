#--- Enable developer mode on the system ---
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name AllowDevelopmentWithoutDevLicense -Value 1

# tools we expect devs across many scenarios will want
choco install -y vscode
choco install -y git

#choco install -y python
#choco install -y sysinternals
