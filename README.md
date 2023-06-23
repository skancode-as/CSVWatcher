# PowerShell File Watcher

This PowerShell script monitors the Downloads folder for new CSV files and organizes them automatically. It moves the existing file in the Documents folder to an Archive folder, adds a timestamp to the file name, and then moves the new file to the Documents folder.

## Features

- Ascii art banner displayed at script start.
- Monitors the Downloads folder for new .csv files.
- Creates an Archive folder in the script's directory if it doesn't exist.
- Moves existing .csv files from the Documents folder to the Archive folder with a timestamp.
- Moves newly downloaded .csv files to the Documents folder.
- Logs all actions to a log file.
- Continuously watches for changes using an infinite loop.

## Prerequisites

- PowerShell 5.1 or higher

## Usage

- Specify the folder path to monitor by modifying the $downloadsPath variable.
- Run the script.
- The script will continuously watch the specified folder for new .csv files and perform the necessary actions.
- Press `Ctrl+C` to stop the script.
