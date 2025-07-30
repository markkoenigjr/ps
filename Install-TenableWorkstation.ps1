#!ps
#timeout=10000000000

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$compname = $env:COMPUTERNAME
$group = "Workstation" # Workstation or Server
Invoke-WebRequest -Uri "https://sensor.cloud.tenable.com/install/agent/installer/ms-install-script.ps1" -OutFile "./ms-install-script.ps1"; & "./ms-install-script.ps1" -key "045fcbc7651029a466a1e9097a1b48e3fe5a91774ae7171ec91e7cf2fc5b2f1c" -type "agent" -name $compname -groups $group; Remove-Item -Path "./ms-install-script.ps1"