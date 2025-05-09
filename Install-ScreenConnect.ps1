#!ps
#timeout=1000000

# Constants
$fileName       = $null
$folderPath     = $null
$fullFilePath   = $null
$uri            = $null

if ($IsWindows -or $([environment]::OSVersion.Platform) -eq "Win32NT") {
    $root           = [System.IO.Path]::GetPathRoot($PWD)
    $fileExtension  = "exe"
    $fileName       = "sc.$fileExtension"
    $folderPath     = Join-Path -Path $root -ChildPath "ScreenConnect"
    $fullFilePath   = Join-Path -Path $folderPath -ChildPath $fileName
    $uri            = "https://5555.screenconnect.com/Bin/ScreenConnect.ClientSetup.$($fileExtension)?e=Access&y=Guest"
}

# Incorporate MacOS and Linux installation routines.
if ($IsMacOS -Or $IsLinux) {
    $root           = pwd
    $fileExtension  = "sh"
    $fileName       = "sc.$fileExtension"
    $folderPath     = Join-Path -Path $root -ChildPath "ScreenConnect"
    $fullFilePath   = Join-Path -Path $folderPath -ChildPath $fileName
    $uri            = "https://5555.screenconnect.com/Bin/ScreenConnect.ClientSetup.$($fileExtension)?e=Access&y=Guest"
}

# Create the folder path
New-Item -ItemType Directory -Path $folderPath -Force

# Download the file
Invoke-WebRequest -Uri $uri -OutFile $fullFilePath

# Initiate the process
if ($IsWindows -or $([environment]::OSVersion.Platform) -eq "Win32NT") {
    Start-Process -FilePath $fullFilePath
}

if ($IsMacOS) {
    Start-Process -FilePath "/usr/bin/sudo" -ArgumentList "pwsh", "-c", "'$fullFilePath'"
}
