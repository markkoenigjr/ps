#!ps
#timeout=10000000000
# Get the file.
 
# Variables
$filepath = "C:\tempsumo"
$downloadInstaller = "https://collectors.us2.sumologic.com/rest/download/win64"
$outfileInstaller = "$filepath\sumologic.exe"
$outfileJson = "$filepath\winsource.json"
$token = "U1VNT0RFYW0wNGc1V0tpUnpZSERaakJPZFlJbmpaTWRodHRwczovL2NvbGxlY3RvcnMudXMyLnN1bW9sb2dpYy5jb20="
$jsonData = '{
  "api.version":"v1",
  "source":{
    "name":"Windows Events",
    "category":"Windows/Events",
    "automaticDateParsing":true,
    "multilineProcessingEnabled":false,
    "useAutolineMatching":false,
    "forceTimeZone":false,
    "filters":[{
      "filterType":"Exclude",
      "name":"Drop 4662 Machine Acct",
      "regexp":"(?s).*EventCode\\s=\\s4662.*Account\\sName:\\s+(?:.*\\$)(?s).*"
    },{
      "filterType":"Exclude",
      "name":"Drop 4672 Machine accounts",
      "regexp":"(?s).*EventCode\\s=\\s4672.*Account\\sName:\\s+(?:.*\\$)(?s).*"
    },{
      "filterType":"Exclude",
      "name":"Drop 4624 Impersonation",
      "regexp":"(?s).*EventCode\\s=\\s4624.*Logon Type:\\s+(?:3|4|5|8).*Impersonation\\sLevel:\\t\\tImpersonation(?s).*"
    },{
      "filterType":"Exclude",
      "name":"Drop 4769 Audit Failure",
      "regexp":"(?s).*EventCode\\s=\\s4769.*Type\\s=\\s\"Audit Failure\".*"
    },{
      "filterType":"Mask",
      "name":"4624_4769 Mask",
      "regexp":"(This event is(?s).*\\.\\\")",
      "mask":"~"
    },{
      "filterType":"Mask",
      "name":"Insertion_Strings_Mask",
      "regexp":"(?s)(InsertionStrings = .*\\};)(?s)",
      "mask":"~"
    }],
    "cutoffTimestamp":1731823200000,
    "encoding":"UTF-8",
    "fields":{
      
    },
    "hashAlgorithm":"MD5",
    "allowlist":"",
    "renderMessages":true,
    "logNames":["Security"],
    "denylist":"4627,4634,4656,4658,4661,4663,4689,4690,4703,4932,4933,5058,5061,5152,5154,5156,5157,5158",
    "eventFormat":0,
    "eventMessage":1,
    "sidStyle":2,
    "sourceType":"LocalWindowsEventLog"
  }
}'

 
# Create the temp directory if it doesn't exist.
if (-Not (Test-Path -Path $filepath)) {
    Write-Host "c:\temp does not exist. Creating folder."
    New-Item -Path $filepath -ItemType "Directory"
}
 
# Download Sumo
try {
    Invoke-WebRequest -Uri $downloadInstaller -OutFile $outfileInstaller
} catch {
    Write-Host "There was a problem downloading a file."
    Exit
}
 
# Create the JSON file
try {
    $jsonData | Set-Content -Path $outfileJson
} catch {
    Write-Host "There was a problem creating the JSON file."
}
 
try {
    Write-Host "Beginning the installation of the Sumo Logic client."
    Start-Process -FilePath $outfileInstaller -ArgumentList "-console","-q","-Vsumo.token_and_url=$token","-Vsources=$outfileJson" -Wait
    Write-Host "Sumo Logic client installed successfully. Please check the Sumo Logic console."
}
catch {
    Write-Host "There was a problem installing the file. Please manually execute the installation."
    Exit
}

# Cleanup
try {
    Remove-Item -Path $filepath -Recurse
} catch {
    Write-Host "There was a pronblem deleting the files. You must manually delete them."
}
