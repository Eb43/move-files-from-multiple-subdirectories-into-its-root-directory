@echo off
setlocal enabledelayedexpansion

set destination_folder=%CD%

for /r %%i in (*) do (
    set "file=%%i"
    if not "!file:%~dp0=!"=="!file!" (
        move "%%i" "%destination_folder%"
    )
)
