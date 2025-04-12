#!ps
#timeout=1000000
#maxlength=10000000000
<#
    .SYNOPSIS
    Export process for transferring Wi-Fi connections to a new machine.

    .DESCRIPTION
    Allows you to export and import Wi-Fi connections from one machine to another.

    .NOTES
    Created by: Mark Koenig
    Date:       2025-04-11
    Revision:   0
#>

# Variables
$folderPathRoot = "c:"
$folderPathContainer = "wifi-export"

# Create the PS drive for HKEY Users
$driveName = "HKU"
$drive = Get-PsDrive -Name $driveName -ErrorAction SilentlyContinue
if (!($drive)) {
    New-PSDrive -PSProvider Registry -Name $driveName -Root HKEY_USERS
}

function Get-FolderPath {
    # Find the current user's OneDrive redirection
    # See if the user is logged in
    if ($username = (Get-CimInstance -class win32_computersystem).username) {
        # If the user is logged in ...
        # Get the SID
        $sid = (New-Object Security.Principal.NTAccount($username)).Translate([Security.Principal.SecurityIdentifier]).Value

        # Get the path to the documents folder
        $folderValue = "{F42EE2D3-909F-4907-8871-4C22FC0BF756}" # This is the documents folder identifier.
        $folderPathRoot = Get-ItemProperty -Path "HKU:\$sid\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" $folderValue -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $folderValue
    }

    # Concatenate the paths
    $folderPath = "$folderPathRoot\$folderPathContainer"
    return $folderPath
}

function Export-WiFi {
    # Test for the Wi-Fi output directory
    if (Test-Path -Path $outputDirectory -PathType Container) {
        Remove-Item -Path $outputDirectory -Recurse -Force
    } 
    
    # Create the folder
    New-Item -Path $outputDirectory -ItemType Directory -Force
    
    # Output all of the WLAN connections.
    netsh wlan export profile key=clear folder=$outputDirectory

    # Create a text file with the name of the computer. This is to protect the import process
    # from occurring on the machine that the connections were exported from.
    $env:COMPUTERNAME | Out-File -FilePath $deviceNameFile

    # Inform the client of what to do next:
    Write-Host "Files created in '$outputDirectory'." -ForegroundColor Magenta

}

# Variables
$outputDirectory    = Get-FolderPath
$deviceNameFile     = "$outputDirectory\device.txt"

# Process the command
Export-WiFi
