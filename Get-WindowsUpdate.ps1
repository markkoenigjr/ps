#!ps
#timeout=100000000

# Create the update session
$UpdateSession  = New-Object -ComObject Microsoft.Update.Session
$UpdateSearcher = $UpdateSession.CreateUpdateSearcher()

Write-Host "Searching for updates. Please be patient."
$Updates        = @($UpdateSearcher.Search("IsHidden=0").Updates)

# List available updates
if ($Updates) {
    Write-Host "`nUPDATES AVAILABLE"
    $Updates | Where-Object { !$_.IsInstalled } | Select-Object Title | Format-Table
} else {
    Write-Host "`nNo updates found.`n"
}
