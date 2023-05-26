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
