#!ps
#timeout=1000000
#https://ps.hfgrp.com/adp

# PREREQUISITES
# Confirm that PowerShell version 7 is running
if ($PSVersionTable.PSVersion.Major -ne 7) {
    Write-Error "This script requires PowerShell 7. Please update your PowerShell version."
    exit 1
}

# Confirm the required modules are installed
$modules = ("PnP.PowerShell")
foreach ($module in $modules) {
    # See if the module is installed
    # Depends on PowerShell 7+
    if (-not (Get-Module -ListAvailable -Name $module)) {
        # Install the module if it is not found
        Install-Module -Name $module -AcceptLicense -Force
    }
    # Import the module
    Import-Module $module
}

### VARIABLES ###
$clientId           = "ec6e053b-7483-4c2b-84bd-a32f53f0abf6"
$tenant             = "hufriedy.onmicrosoft.com"
$siteUrl            = "https://hufriedy.sharepoint.com/sites/Hu-FriedyDesktopServices"
$fileRelativeUrl    = "/Shared%20Documents/Tech%20Articles/Powershell%20Scripts/ADP/Import-AdpData.ps1"

# Connect to SharePoint
Connect-PnPOnline -Url $siteUrl -ClientId $clientId -Tenant $tenant -Interactive

# Get file from SharePoint
try {
    $file = Get-PnPFile -Url $fileRelativeUrl -AsString
    Invoke-Expression $file

} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Disconnect from SharePoint Online
Disconnect-PnPOnline -ErrorAction SilentlyContinue
