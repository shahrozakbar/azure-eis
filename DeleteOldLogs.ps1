$logPaths = @("C:\inetpub\logs\", "D:\inetpub\logs\", "E:\inetpub\logs\")
$maxDaysToKeep = -30
$dateThreshold = (Get-Date).AddDays($maxDaysToKeep)
$deleteCount = 0


foreach ($logPath in $logPaths) {
    if (Test-Path $logPath) {
        Write-Output "Checking: $logPath"

        $itemsToDelete = Get-ChildItem -Path $logPath -Recurse -Filter *.log | Where-Object { $_.LastWriteTime -lt $dateThreshold }

        foreach ($item in $itemsToDelete) {
            Write-Output "Deleting: $($item.FullName)"
            Remove-Item -Path $item.FullName -Force -Verbose
            $deleteCount++
        }
    } else {
        Write-Output "Path does not exist: $logPath"
    }
}

Write-Output "Total files deleted: $deleteCount"