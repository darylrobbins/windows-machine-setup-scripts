function Get-VSVsixExtensionUri {
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