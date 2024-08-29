# Define the paths to the IIS log directories
$logPaths = @(
    "C:\inetpub\logs\",
    "D:\inetpub\logs\",
    "E:\inetpub\logs\"
)

# Function to check if the IIS feature is installed
Function Check-IISFeature {
    $iisFeature = Get-WindowsFeature -Name Web-Server
    if ($iisFeature.Installed) {
        Write-Output "IIS is installed and operational."
    } else {
        Write-Output "IIS is not installed. Please install IIS to proceed."
        Exit
    }
}

# Function to delete log files older than 30 days
Function Delete-OldLogs {
    foreach ($path in $logPaths) {
        if (Test-Path $path) {
            Write-Output "Checking log files in $path"
            Get-ChildItem -Path $path -Recurse -File |
                Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } |
                ForEach-Object {
                    Write-Output "Deleting file: $($_.FullName)"
                    Remove-Item -Path $_.FullName -Force
                }
        } else {
            Write-Output "Directory $path does not exist."
        }
    }
}

# Main script execution
Check-IISFeature
Delete-OldLogs
