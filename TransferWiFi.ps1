#!ps
#timeout=1000000
<#
.SYNOPSIS
Transfer Wi-Fi connections to a new machine.

.DESCRIPTION
Allows you to export and import Wi-Fi connections from one machine to another.
Instructions:
    1. Open a ScreenConnect backstage session on the user's old computer.
    2. Open a ScreenConnect session (console or backstage) on the user's new computer.
    3. Initiate a PowerShell session.
    4. Run the script.
    5. Copy the folder from the old computer to the new computer.
    6. Run the script on the new computer to complete the import.
    
    NOTE: This script CANNOT be executed from the ScreenConnect command console.

.NOTES
Created by: Mark Koenig
Date:       2025-04-11
Revision:   0
#>

# Variables
$outputDirectory    = "C:\wifi"
$deviceNameFile     = "$outputDirectory\device.txt"

function Export-WiFi {
    # Test for the Wi-Fi output directory
    if (Test-Path -Path $outputDirectory -PathType Container) {
        # Prompt to overwrite if it does exist
        Write-Host "The directory $outputDirectory exists." -ForegroundColor Cyan
        $overwrite = Read-Host "Overwrite? (y/n)"

        if ($overwrite -eq "y") {
            Remove-Item -Path $outputDirectory -Recurse -Force
            New-Item -ItemType Directory -Path $outputDirectory
        } else {
            Write-Host "Exiting" -ForegroundColor Yellow
            return
        }
    } else {
        # Create the folder if it doesn't exist
        New-Item -Path $outputDirectory -ItemType Directory
    }

    # Output all of the WLAN connections.
    netsh wlan export profile key=clear folder=$outputDirectory

    # Create a text file with the name of the computer. This is to protect the import process
    # from occurring on the machine that the connections were exported from.
    $env:COMPUTERNAME | Out-File -FilePath $deviceNameFile

    # Inform the client of what to do next:
    Write-Host "Copy the $outputDirectory folder to the new computer." -ForegroundColor Magenta

}

function Import-WiFi {
    Write-Host "Attempting to import Wi-Fi connections ..."
    
    # Check if the directory exists.
    if (!(Test-Path -Path $outputDirectory -PathType Container)) {
        Write-Host "$outputDirectory doesn't exist. Please copy this folder from the host machine first." -ForegroundColor Red
        return
    }

    # Check if the user is attempting to import on the same computer that generated the exported files.
    if ((Get-Content -Path $deviceNameFile) -eq $env:COMPUTERNAME) {
        Write-Host "This is the export computer. Please attempt to import these connections on a different machine." -ForegroundColor Red
        return
    }

    # Import the connections.    
    foreach ($file in (Get-ChildItem $outputDirectory -Filter "*.xml")) {
        netsh wlan add profile filename=$file user=all
    }

    Write-Host "Import complete. You are all done." -ForegroundColor Green

}

# Select what to do:
function Show-Menu {
    Write-Host "Selections:"
    Write-Host "1. Export Wi-Fi Connections"
    Write-Host "2. Import Wi-Fi Connections"
    Write-Host "3. Exit (default)"

    $selection = Read-Host "Enter selection"

    switch ($selection) {
        "1" {
            Export-WiFi
        }
        "2" {
            Import-WiFi
        }
        "3" {
            Write-Host "Exiting" -ForegroundColor Yellow
            return
        }
        default {
            Write-Host "Invalid selection." -ForegroundColor Yellow
            Show-Menu
        }
    }
}

Show-Menu
