####### VARIABLES #######
$destinationFolder = Join-Path -Path "C:" -ChildPath "temp"

# PATHS
$siteInstallerUrls = @{
    "AZ003"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/AZ003-HuFriedyGroup_Windows_OS_ITSPlatform_TKN1d6b6fd7-0742-4b7e-b67e-947d8916bb88/MSI/setup"
    "CN004"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/CN004-HuFriedyGroup_Windows_OS_ITSPlatform_TKN1bd535ff-ae78-425c-8aab-d7d6c41819e4/MSI/setup"
    "CO002"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/CO002-HuFriedyGroup_Windows_OS_ITSPlatform_TKNaf787c1a-c98e-467f-b0a8-e352490c0966/MSI/setup"
    "CT001"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/CT001-HuFriedyGroup_Windows_OS_ITSPlatform_TKNe34ce145-a45b-4983-aa0f-593e4b3c49e3/MSI/setup"
    "DE004"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/DE004-HuFriedyGroup_Windows_OS_ITSPlatform_TKNa6e4fcd2-074b-4372-90ef-f3812e53ad13/MSI/setup"
    "DE005"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/DE005-HuFriedyGroup_Windows_OS_ITSPlatform_TKNa2207e98-402d-4745-b017-0fdc6bb27a11/MSI/setup"
    "GA002"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/GA002-HuFriedyGroup_Windows_OS_ITSPlatform_TKN16bb6973-5949-47b1-ba8f-358ba0d85c21/MSI/setup"
    "GR001"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/GR001-HuFriedyGroup_Windows_OS_ITSPlatform_TKN5f1b3d9b-14f6-4cd6-be2b-8e11d58bd110/MSI/setup"
    "IL001"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IL001-HuFriedyGroup_Windows_OS_ITSPlatform_TKN0750af32-ef4a-472a-9745-34613af2ed3d/MSI/setup"
    "IL002"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IL002-HuFriedyGroup_Windows_OS_ITSPlatform_TKNe30eeb50-79ae-4b55-9b9b-95ec686629d9/MSI/setup"
    "IL003"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IL003-HuFriedyGroup_Windows_OS_ITSPlatform_TKN5297a2f0-d821-4553-9bfb-911060e27e40/MSI/setup"
    "IL004"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IL004-HuFriedyGroup_Windows_OS_ITSPlatform_TKN044beeda-782e-4650-99f9-5dfdac51e576/MSI/setup"
    "IL005"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IL005-HuFriedyGroup_Windows_OS_ITSPlatform_TKN3f4be206-9c76-4425-8ee5-cc53d6f53db7/MSI/setup"
    "IT002"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IT002-HuFriedyGroup_Windows_OS_ITSPlatform_TKNd76ffb63-649a-4508-b45c-872379c9ec6f/MSI/setup"
    "IT003"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IT003-HuFriedyGroup_Windows_OS_ITSPlatform_TKN1492ff33-f2b3-47e9-ba4c-88fad177924d/MSI/setup"
    "IT004"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IT004-HuFriedyGroup_Windows_OS_ITSPlatform_TKN446b9a8d-ba72-4ab1-b144-6125721d81ab/MSI/setup"
    "IT005"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/IT005-HuFriedyGroup_Windows_OS_ITSPlatform_TKNc2a6e2be-8f56-4638-bb41-c8aff8f8b3d9/MSI/setup"
    "JP001"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/JP001-HuFriedyGroup_Windows_OS_ITSPlatform_TKNa33e8500-91a2-4b08-884e-a279d858caa8/MSI/setup"
    "MX001"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/MX001-HuFriedyGroup_Windows_OS_ITSPlatform_TKN489ae988-e2b0-4f73-aee2-e8b11f67e6ba/MSI/setup"
    "NJ001"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/NJ001-HuFriedyGroup_Windows_OS_ITSPlatform_TKNc8be9898-05eb-4d82-96f9-6cc112f09f1c/MSI/setup"
    "NY003"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/NY003-HuFriedyGroup_Windows_OS_ITSPlatform_TKN8358f9ac-18a7-4e10-ae14-316a87043a15/MSI/setup"
    "NY005"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/NY005-HuFriedyGroup_Windows_OS_ITSPlatform_TKN96fa0fb9-2467-40b7-9d07-16f096b06d39/MSI/setup"
    "NY006"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/NY006-HuFriedyGroup_Windows_OS_ITSPlatform_TKN82cc17ef-23c5-46fd-ba39-c2ed6360bd93/MSI/setup"
    "PA002"     = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/PA002-HuFriedyGroup_Windows_OS_ITSPlatform_TKNf77359d2-0f55-4071-b007-8f2076aeaf4c/MSI/setup"
    "REM-AU000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-AU000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN475ed6e8-7dc8-424d-b397-8104b364c360/MSI/setup"
    "REM-BR000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-BR000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN05218a7e-b612-4d36-9252-ddf0e1c365de/MSI/setup"
    "REM-CA000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-CA000-HuFriedyGroup_Windows_OS_ITSPlatform_TKNd41d25f0-2b0e-412d-bfd1-6bb3603e35cf/MSI/setup"
    "REM-CN000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-CN000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN4d3cf6c2-a715-4a76-b7c0-a236a293e338/MSI/setup"
    "REM-CO000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-CO000-HuFriedyGroup_Windows_OS_ITSPlatform_TKNf2cf16a8-6291-45ea-bb5c-2ea5f9af3104/MSI/setup"
    "REM-CR000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-CR000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN20ca5e7a-857c-430c-8bc3-ef85129516ec/MSI/setup"
    "REM-DE000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-DE000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN3cfab68d-b9cb-4f2c-b977-6110b5d72bdd/MSI/setup"
    "REM-ES000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-ES000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN64ebb34a-1578-45f6-8483-2b562d0d21b9/MSI/setup"
    "REM-FR000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-FR000-HuFriedyGroup_Windows_OS_ITSPlatform_TKNbfcd54d3-7385-4d2f-9f9f-2c6e556b2139/MSI/setup"
    "REM-IT000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-IT000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN871c8072-0c1e-43af-8d5e-6062a22578c4/MSI/setup"
    "REM-JP000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-JP000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN714a7a1b-e98a-4349-b805-a5f9e40788b0/MSI/setup"
    "REM-MX000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-MX000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN696e0c22-d3ab-410c-84b2-fb8239ddc3c0/MSI/setup"
    "REM-TH000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-TH000-HuFriedyGroup_Windows_OS_ITSPlatform_TKN9e151889-3291-44dc-b5d9-70d929328bdb/MSI/setup"
    "REM-US000" = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/REM-US000-HuFriedyGroup_Windows_OS_ITSPlatform_TKNa857bf87-cc68-4756-bd69-e82e213c5c80/MSI/setup"
    "SYMMETRY"  = "https://prod.setup.itsupport247.net/windows/BareboneAgent/32/Symmetry-HuFriedyGroup_Windows_OS_ITSPlatform_TKN0003a875-1dab-413e-a53c-25922bd4d623/MSI/setup"
}


####### FUNCTIONS #######
function Save-UrlFileFromPath {
    param(
        [Parameter(Mandatory)]
        [string]$Url,
        [string]$DestinationFolder = $env:TEMP
    )

    $uri = [System.Uri]$Url
    $segments = $uri.AbsolutePath.Trim('/') -split '/'

    if ($segments.Count -lt 3) {
        throw "URL path must contain at least three segments."
    }

    $baseName = $segments[-3]
    $extension = $segments[-2].ToLower()
    $fileName = "$baseName.$extension"

    if (-not (Test-Path $DestinationFolder)) {
        New-Item -ItemType Directory -Path $DestinationFolder -Force | Out-Null
    }

    $destination = Join-Path $DestinationFolder $fileName

    Write-Host "Downloading:"
    Write-Host "  From: $Url"
    Write-Host "  To:   $destination"

    curl.exe -L $Url -o $destination

    if ($LASTEXITCODE -ne 0) {
        throw "curl.exe failed with exit code $LASTEXITCODE"
    }

    return $destination
}

####### PROCEDURE #######
# Null the key ... just in case
$key = $null
do {
    $key = (Read-Host "Enter site id").Trim().ToUpper()
    if (-not $siteInstallerUrls.ContainsKey($key)) {
        Write-Warning "Site '$key' not found. Please try again."
    }

} while (-not $siteInstallerUrls.ContainsKey($key))

# Save the file
if ($filePath = Save-UrlFileFromPath -Url $siteInstallerUrls[$key] -DestinationFolder $destinationFolder) {
    Start-Process msiexec.exe -ArgumentList "/i `"$filePath`"" -Wait
}