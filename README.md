# move-files-from-multiple-subdirectories-into-its-root-directory

a BAT file that moves any file from any subfolder within the folder the BAT file is located in.

The BAT file content:

```

@echo off
setlocal enabledelayedexpansion

set destination_folder=%CD%

for /r %%i in (*) do (
    set "file=%%i"
    if not "!file:%~dp0=!"=="!file!" (
        move "%%i" "%destination_folder%"
    )
)

```

Explanation:

- `@echo off` turns off echoing of commands in the command prompt window.
- `setlocal enabledelayedexpansion` enables the use of delayed expansion, which allows us to expand variables inside a for loop.
- `set destination_folder=%CD%` sets the destination folder where the files will be moved to. The folder address is chosen as a current folder the BAT file is located in.
- `for /r %%i in (*) do` starts a for loop that iterates through all files in all subfolders recursively.
- `set "file=%%i"` sets the `file` variable to the current file being iterated.
- `if not "!file:%~dp0=!"=="!file!"` checks if the current file's path contains the path of the batch file. `%~dp0` expands to the drive letter and path of the batch file, so this condition checks if the current file is in a subfolder of the batch file's folder.
- `move "%%i" "%destination_folder%"` moves the file to the specified destination folder.


# Moving files with special characters in the name

BAT file provided above skips files with special characters in the name (!. ', ?) due to how Windows deals with such files. The powershell script moves files with special characters in the name correctly. It prints a message for each move operation, or a message when a file with the same name exists in the destination directory.

To use this script, save it as a .ps1 file, for instance MoveFiles.ps1, and run it with PowerShell. If you have never run a PowerShell script before, you might need to change your script execution policy. You can do this by opening PowerShell as an Administrator and running Set-ExecutionPolicy RemoteSigned, then confirm the change by typing Y and pressing Enter. This needs to be done only once.

```
$source = Get-Location
Get-ChildItem $source -Recurse | Where-Object {!$_.PSIsContainer} | ForEach-Object {
    $destination = Join-Path $source $_.Name
    if (!(Test-Path -Path $destination -PathType Leaf)) {
        Move-Item $_.FullName $destination
        Write-Output "Moved $($_.FullName) to $destination"
    } else {
        Write-Output "File $($_.Name) already exists in the destination folder"
    }
}
```


- `$source = Get-Location` gets the current location (directory) where the script is running.
- `Get-ChildItem $source -Recurse` gets a list of all child items within the source directory recursively . This includes files in all subfolders.
- `ForEach-Object` checks whether a file with the same name exists in the destination directory ($destination = Join-Path $source $_.Name and Test-Path -Path $destination -PathType Leaf).
- If a file with the same name does not exist in the destination directory, it moves the file (Move-Item $_.FullName $destination).
