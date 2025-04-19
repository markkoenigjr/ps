#!ps
#timeout=1000000

# Constants
$fileName       = $null
$folderPath     = $null
$fullFilePath   = $null
$uri            = $null

if ($IsWindows) {
    $root           = [System.IO.Path]::GetPathRoot($PWD)
    $fileExtension  = "exe"
    $fileName       = "sc.$fileExtension"
    $folderPath     = Join-Path -Path $root -ChildPath "ScreenConnect"
    $fullFilePath   = Join-Path -Path $folderPath -ChildPath $fileName
    $uri            = "https://5555.screenconnect.com/Bin/ScreenConnect.ClientSetup.$($fileExtension)?e=Access&y=Guest"
}

# Incorporate MacOS and Linux installation routines.
if ($IsMacOS -Or $IsLinux) {
    $root           = "/"
    $fileExtension  = "sh"
    $fileName       = "sc.$fileExtension"
    $folderPath     = Join-Path -Path $root -ChildPath "ScreenConnect"
    $fullFilePath   = Join-Path -Path $folderPath -ChildPath $fileName
    $uri            = "https://5555.screenconnect.com/Bin/ScreenConnect.ClientSetup.$($fileExtension)?e=Access&y=Guest"
}

Write-Host $uri

# Create the folder path
New-Item -ItemType Directory -Path $folderPath -Force

# Download the file
Invoke-WebRequest -Uri $uri -OutFile $fullFilePath

# Initiate the process
Start-Process -FilePath $fullFilePath
