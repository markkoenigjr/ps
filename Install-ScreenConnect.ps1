#!ps
#timeout=1000000

# Variables
$fileName       = "sc.exe"
$folderPath     = Join-Path -Path $PWD -ChildPath "ScreenConnect"
$fullFilePath   = Join-Path -Path $folderPath -ChildPath $fileName
$uri            = "https://5555.screenconnect.com/Bin/ScreenConnect.ClientSetup.exe?e=Access&y=Guest"

# Create the folder path
New-Item -ItemType Directory -Path $folderPath

# Download the file
Invoke-WebRequest -Uri $uri -OutFile $fullFilePath

# Initiate the process
Start-Process -FilePath $fullFilePath
