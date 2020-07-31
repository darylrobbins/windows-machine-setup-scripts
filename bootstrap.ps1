#####################
# PREREQUISITES
#####################

# Windows Updates
Install-WindowsUpdate -AcceptEula -Criteria "IsHidden=0 and IsInstalled=0 and Type='Software'"

Set-ExplorerOptions -showHiddenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
Set-TaskbarSmall

# Console
cinst PowerShell
cinst poshgit
cinst microsoft-windows-terminal

# WinGet
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v0.1.42101-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -OutFile ~/winget-cli.appx -UseBasicParsing
Add-AppxPackage -Path ~/winget-cli.appx

#####################
# WINDOWS FEATURES
#####################

cinst Microsoft-Hyper-V-All -source windowsFeatures
cinst IIS-WebServerRole -source windowsfeatures

#####################
# SOFTWARE
#####################

# 7Zip
cinst 7zip.install -y

# Some browsers
# cinst GoogleChrome -y
# cinst chromium -y
cinst firefox -y
# cinst firefox-dev --pre -y
# cinst Opera -y
cinst microsoft-edge -y
# cinst microsoft-edge-insider -y
# cinst microsoft-edge-insider-dev -y

#Plugins and Runtime
cinst javaruntime -y

# Dev Tools
cinst git.install -y
cinst git-credential-winstore
cinst poshgit
cinst nvm -y
cinst cascadiacode -y
cinst vscode -y
# cinst vscode-insiders -y
cinst gitkraken -y
cinst github-desktop -y
cinst postman -y
# cinst fiddler -y
# cinst teamviewer -y
cinst azure-cli -y

# VS Code Extensions
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension 42Crunch.vscode-openapi
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension azuredevspaces.azds
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension AzurePolicy.azurepolicyextension
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension budparr.language-hugo-vscode
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension bungcip.better-toml
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension erd0s.terraform-autocomplete
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension formulahendry.azure-storage-explorer
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension golang.go
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension hashicorp.terraform
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension humao.rest-client
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension mindaro-dev.file-downloader
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension mindaro.mindaro
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension mohsen1.prettify-json
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azure-devops.azure-pipelines
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-apimanagement
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-azureappservice
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-azurefunctions
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-azureresourcegroups
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-azurestorage
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-azureterraform
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-azurevirtualmachines
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-cosmosdb
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-docker
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-azuretools.vscode-logicapps
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-dotnettools.vscode-dotnet-runtime
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-kubernetes-tools.vscode-aks-tools
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-mssql.mssql
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-python.python
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-vscode.azure-account
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-vscode.azurecli
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-vscode.powershell
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-vscode.vscode-node-azure-pack
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-vsliveshare.vsliveshare
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension ms-vsts.team
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension msazurermtools.azurerm-vscode-tools
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension neilding.language-liquid
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension redhat.java
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension redhat.vscode-yaml
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension sissel.shopify-liquid
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension Summer.azure-event-hub-explorer
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension VisualStudioExptTeam.vscodeintellicode
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension vscjava.vscode-java-debug
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension vscjava.vscode-java-dependency
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension vscjava.vscode-java-pack
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension vscjava.vscode-java-test
& "C:\Program Files\Microsoft VS Code\bin\code" --install-extension vscjava.vscode-maven

# Messaging
# cinst discord -y
cinst microsoft-teams -y
cinst slack -y
# cinst whatsapp -y
# cinst telegram -y
# cinst skype -y

# Tools
# cinst foxitreader -y
cinst vlc -y
cinst ccleaner -y
# cinst rescuetime -y
# cinst nordvpn -y
cinst powertoys -y
cinst 1password -y

# Graphic Tools
# cinst paint.net -y

# Audio Tools
# cinst audacity -y
# cinst lightworks -y
# cinst screentogif -y
# cinst spotify --ignore-checksums -y

# Visual Studio
cinst visualstudio2019community -y --package-parameters="--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"

# Portal Azure
Invoke-WebRequest -Uri https://portal.azure.com/App/Download?acceptLicense=true -OutFile ~/AzurePortalInstaller.exe -UseBasicParsing
Start-Process ~/AzurePortalInstaller.exe

# Manually
# Xmeters
# Visual Studio 2019
# Portal Azure