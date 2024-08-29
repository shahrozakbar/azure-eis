$filePath = "C:\inetpub\logs\LogFiles\W3SVC1\dummy_iis_log_older_than_30_days.log"

$newDate = (Get-Date).AddDays(-60)
(Get-Item $filePath).LastWriteTime = $newDate
(Get-Item $filePath).CreationTime = $newDate
(Get-Item $filePath).LastAccessTime = $newDate

Write-Output "Modified date of $filePath set to $newDate"
