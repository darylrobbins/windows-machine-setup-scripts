# Install winget
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v0.1.42101-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -OutFile ~/winget-cli.appx -UseBasicParsing
Add-AppxPackage -Path ~/winget-cli.appx