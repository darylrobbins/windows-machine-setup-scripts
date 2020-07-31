#--- Enable developer mode on the system ---
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name AllowDevelopmentWithoutDevLicense -Value 1

# tools we expect devs across many scenarios will want
choco install -y vscode
choco install -y git

# Install Windows Terminal from Microsoft Store
# Start-Process ms-windows-store://pdp/?ProductId=9n0dx20hk701
winget install --id=Microsoft.WindowsTerminal -e

#choco install -y python
#choco install -y sysinternals

# Install Azure Portal app
Invoke-WebRequest -Uri https://portal.azure.com/App/Download?acceptLicense=true -OutFile ~/AzurePortalInstaller.exe -UseBasicParsing
Start-Process ~/AzurePortalInstaller.exe
