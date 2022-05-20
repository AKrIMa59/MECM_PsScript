$bloatware_file= Get-Content .\bloatware-list.txt
#On vérifie si winget est présent sur le pc
foreach ($line in $bloatware_file) {
    Write-Output $line
    winget uninstall $line --accept-source-agreements
}