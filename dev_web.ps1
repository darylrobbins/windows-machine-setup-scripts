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
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
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

# Install SQL Server, must be installed before other VC++ Redist
choco install -y sql-server-2019

#--- Install applications ---
executeScript "Browsers.ps1";
executeScript "CommonApps.ps1";
executeScript "CommonDevTools.ps1";
RefreshEnv

Install-Module -Force posh-git

choco install -y sql-server-management-studio

# For DbGeography if not mistaken
# Should be Microsoft System CLR Types for SQL Server 2012 http://go.microsoft.com/fwlink/?LinkID=239644&clcid=0x409
#choco install sql2016-clrtypes

#--- Installing Visual Studio ---
# See this for install args: https://chocolatey.org/packages/VisualStudio2019Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2019community
# visualstudio2019professional
# visualstudio2019enterprise

$idList = @(
    "Microsoft.VisualStudio.Workload.Azure",
    "Microsoft.VisualStudio.Workload.NetWeb", 
    "Microsoft.VisualStudio.Workload.ManagedDesktop",
    "Microsoft.VisualStudio.Workload.NetCoreTools",
    "Microsoft.VisualStudio.Component.Git",
    "Microsoft.Net.Component.4.7.2.SDK",
    "Microsoft.Net.Component.4.7.2.TargetingPack"
);
$paramList = @("--includeRecommended");
$idList | ForEach-Object { $paramList += "--add $_" }
$vsParams = [string]::Join(' ', $paramList)

choco install -y visualstudio2019community --package-parameters="'$vsParams'"
Update-SessionEnvironment #refreshing env due to Git install

# --- Install Visual Studio extensions ---
function getVSVsixExtensionUri {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [Alias("PackageName")]
        [String]
        $ItemId
    )

    $baseProtocol = "https:"
    $baseHostName = "marketplace.visualstudio.com"

    # Retrieve Visual Studio extension page
    $response = Invoke-WebRequest -Uri "$baseProtocol//$baseHostName/items?itemName=$ItemId" -UseBasicParsing
    $Html = New-Object -Com "HTMLFile"
    $Html.IHTMLDocument2_write($response.Content)
    $extensionName = $Html.Title
    Write-Host "Found $extensionName..."

    # Get extension download URL
    $downloadAnchor = $Html.getElementsByTagName("a") | Where-Object -Property "ClassName" -EQ "install-button-container"
    if (-Not $downloadAnchor) {
        Write-Error "Couldn't find download anchor tag."
        Exit 1
    }
    $downloadAnchor.protocol = $baseProtocol
    $downloadAnchor.hostname = $baseHostName

    # Get extension's actual URL that has filename
    $downloadUri = $downloadAnchor.href
    Write-Host "Getting actual download Uri from $downloadUri..."
    $downloadResponse = Invoke-WebRequest -Uri $downloadUri
    $actualDownloadUri = $downloadResponse.BaseResponse.ResponseUri
    if (-Not $actualDownloadUri) {
        Write-Error "Couldn't find actual download URL."
        Exit 1
    }

    return $actualDownloadUri
}

function installVSExtension {
    param([string] $packageName)
    $uri = getVSVsixExtensionUri -PackageName $packageName
    Install-VisualStudioVsixExtension -Name $packageName -Url $uri.AbsoluteUri
}

$extensionIdList = @(
    "josefpihrt.Roslynator2019",
    "SteveCadwallader.CodeMaid",
    "SharpDevelopTeam.ILSpy",
    "PaulHarrington.EditorGuidelines",
    "VisualStudioPlatformTeam.ProductivityPowerPack2017",
    "TomasRestrepo.Viasfora",
    "SonarSource.SonarLintforVisualStudio2019",
    "OlegShilo.DocPreview",
    "MadsKristensen.WebEssentials2019"
)
$extensionIdList | ForEach-Object -Process { installVSExtension $_ }

# --- Install additional dev tools ---
choco install -y postman
choco install -y prefix

# --- Install Chocolatey ---
executeScript "Chocolatey.ps1"

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
