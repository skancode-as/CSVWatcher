# CSV Watcher

Script that watches download folder for when a .csv file is created.

## Action

    Action to take when a .csv file is created in the download folder.
    1. Rename and move the oldest file in the documents folder to the archive folder.
    2. Move the new file to the documents folder.
    3. Write to log file.

## Before running

Create an archive folder

```bash
  New-Item -Name "archive" -ItemType "directory"
```
