# Description: Boxstarter Script
# Author: Cheng Kai Sheng

Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$strpos = $helperUri.LastIndexOf("/demos/")
$helperUri = $helperUri.Substring(0, $strpos)
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	Invoke-Expression ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "SystemConfiguration.ps1";
executeScript "ScreenSaverConfiguration.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "Browsers.ps1";
executeScript "CommonApps.ps1";
executeScript "CommonDevTools.ps1";
Update-SessionEnvironment

Install-Module -Force posh-git
Update-SessionEnvironment

# Install SQL Server
choco install -y sql-server-2019
choco install -y sql-server-management-studio

# For DbGeography if not mistaken
# Should be Microsoft System CLR Types for SQL Server 2012 http://go.microsoft.com/fwlink/?LinkID=239644&clcid=0x409
#choco install sql2016-clrtypes

#--- Tools ---
#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2019Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2019community
# visualstudio2019professional
# visualstudio2019enterprise

$paramList = @('--includeRecommended');
$idList = @(
    "Microsoft.VisualStudio.Workload.Azure",
    "Microsoft.VisualStudio.Workload.NetWeb", 
    "Microsoft.VisualStudio.Workload.ManagedDesktop",
    "Microsoft.VisualStudio.Workload.NetCoreTools",
    "Microsoft.VisualStudio.Component.Git",
    "Microsoft.Net.Component.4.7.2.SDK",
    "Microsoft.Net.Component.4.7.2.TargetingPack"
);
$idList | ForEach-Object { $paramList += "--add $_" }
$vsParams = [System.String]::Join(' ', $paramList)

choco install -y visualstudio2019community --package-parameters="'$vsParams'"
Update-SessionEnvironment #refreshing env due to Git install

# --- Install Visual Studio extensions ---
executeScript "Get-VSVsixExtensionUri.ps1"

function installVSExtension {
    param([string] $packageName)
    $uri = Get-VSVsixExtensionUri -ItemId $packageName
    Install-VisualStudioVsixExtension -Name $packageName -Url $uri.AbsoluteUri
}

$extensionIdList = @(
    "josefpihrt.Roslynator2019",
    "SteveCadwallader.CodeMaid",
    "SharpDevelopTeam.ILSpy",
    "PaulHarrington.EditorGuidelines",
    "VisualStudioPlatformTeam.ProductivityPowerPack2017",
    #"TomasRestrepo.Viasfora",
    "SonarSource.SonarLintforVisualStudio2019",
    "OlegShilo.DocPreview",
    "MadsKristensen.WebEssentials2019"
)
$extensionIdList | ForEach-Object -Process { installVSExtension $extensionId }

# --- Install additional dev tools ---
choco install -y postman
choco install -y prefix

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
