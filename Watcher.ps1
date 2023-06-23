# Paths to folders and files
$downloadPath = "C:\Users\AndreasVifert\Downloads"
$documentsPath = "C:\Users\AndreasVifert\Documents"
$archivePath = "C:\Users\AndreasVifert\Documents\Skancode\CSVWatcher\archive"
$logPath = "C:\Users\AndreasVifert\Documents\Skancode\CSVWatcher\log.txt"

$filter = "*.csv"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $downloadPath
$watcher.Filter = $filter
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

$action = {
    $newFile = $Event.SourceEventArgs.Name
    $oldFile = Get-ChildItem -Path $documentsPath -Filter $filter | Sort-Object -Property LastWriteTime | Select-Object -First 1

    if ($oldFile) {
      $datePrefix = Get-Date -Format "dd-MM-yyyy_HH-mm-ss"
      $newFileName = "${datePrefix}_$($oldFile.Name)"
      $newFilePath = Join-Path -Path $archivePath -ChildPath $newFileName
  
      Move-Item -Path $oldFile.FullName -Destination $newFilePath -Force
  
      $logLine = "$(Get-Date), Moved old file $($oldFile.Name) to archive folder as $($newFileName)."
      Add-Content -Path $logPath -Value $logLine
      Write-Host $logLine
  }

    Move-Item -Path "$downloadPath\$newFile" -Destination $documentsPath -Force
    $logLine = "$(Get-Date), Moved new file $newFile to documents folder."
    Add-Content -Path $logPath -Value $logLine
    Write-Host $logLine
}

Register-ObjectEvent -InputObject $watcher -EventName Created -Action $action

Write-Host "Watching $downloadPath for new .csv files..."
Write-Host "Press Ctrl+C to stop."

while ($true) {
    Wait-Event -Timeout 1
    [System.GC]::Collect()
}
