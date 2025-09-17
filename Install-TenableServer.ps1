#!ps
#timeout=10000000000

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$compname = $env:COMPUTERNAME
$group = "Server" # Workstation or Server

Invoke-WebRequest -Uri "https://sensor.cloud.tenable.com/install/agent/installer/ms-install-script.ps1" -OutFile "./ms-install-script.ps1"; & "./ms-install-script.ps1" -key "beb8bc92780adf8f18f665c464859f6eff9322700e8005fa9f75e9cdc2f5e24e" -type "agent" -name $compname -groups $group; Remove-Item -Path "./ms-install-script.ps1"
