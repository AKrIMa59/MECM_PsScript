$bloatware_file= Get-Content .\bloatware-list.txt
foreach ($line in $bloatware_file) {
    Write-Output $line
    winget $line --accept-source-agreements
}