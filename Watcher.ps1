# Create path variables
$downloadsPath = "$env:USERPROFILE\Downloads"
$documentsPath = "$env:USERPROFILE\Documents"
$scriptRootDirectory = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$archivePath = Join-Path -Path $scriptRootDirectory -ChildPath "Archive"
$logFilePath = Join-Path -Path $scriptRootDirectory -ChildPath "log.txt"

# Create the Archive folder if it doesn't exist
if (-not (Test-Path $archivePath)) {
    New-Item -Path $archivePath -ItemType Directory | Out-Null
}

# Create the Archive folder if it doesn't exist
if (-not (Test-Path $archivePath)) {
    New-Item -Path $archivePath -ItemType Directory | Out-Null
}

# Function to move the existing file to the archive folder with a timestamp
function MoveToArchive([string]$existingFilePath) {
    $existingFile = Get-Item -Path $existingFilePath

    # Generate a timestamp for renaming the existing file
    $timestamp = Get-Date -Format "dd-MM-yyyy_HH-mm-ss"
    $archivedFileName = "{0}_{1}.csv" -f $timestamp, $existingFile.BaseName
    $archivedFilePath = Join-Path -Path $archivePath -ChildPath $archivedFileName

    # Move the existing file to the archive folder with a timestamp
    Move-Item -Path $existingFile.FullName -Destination $archivedFilePath

    # Log the action to the log file
    Add-Content -Path $logFilePath -Value "File '$existingFile' moved to '$archivedFilePath' at $(Get-Date)"
}

# Function to move the newly downloaded file to the Documents folder
function MoveToDocuments([string]$newFilePath) {
    # Move the newly downloaded file to the Documents folder
    Move-Item -Path $newFilePath -Destination $documentsPath

    # Log the action to the log file
    Add-Content -Path $logFilePath -Value "File '$newFilePath' moved to '$documentsPath' at $(Get-Date)"
}

while ($true) {
    # Get all .csv files in the Downloads folder
    $csvFiles = Get-ChildItem -Path $downloadsPath -Filter "*.csv" -File

    foreach ($csvFile in $csvFiles) {
        # Check if there is an existing .csv file in the Documents folder
        $existingFile = Get-ChildItem -Path $documentsPath -Filter "*.csv" -File

        if ($existingFile) {
            MoveToArchive -existingFilePath $existingFile.FullName
        }

        MoveToDocuments -newFilePath $csvFile.FullName
    }

    # Pause for 1 second before checking again
    Start-Sleep -Seconds 1
    [System.GC]::Collect()
}
