@echo off
setlocal enabledelayedexpansion

:: Set the folder path, prefix, and optional character position from command line arguments
set "folderPath=%~1"
set "prefix=%~2"
set "charPos=%~3"

:: Check if folder path and prefix are provided
if "%~1"=="" (
    echo Folder path not provided.
    exit /b 1
)
if "%~2"=="" (
    echo Prefix not provided.
    exit /b 1
)

:: Default character position to 0 if not provided
if "%~3"=="" set "charPos=0"

:: Rename all files in the specified folder with the provided prefix
for %%f in ("%folderPath%\*") do (
    set "fileName=%%~nf"
    set "fileExt=%%~xf"
    call :renameFile "%%f"
)

echo Renaming complete.
goto :eof

:renameFile
setlocal
set "file=%~1"
set "name=!fileName!"
set "ext=!fileExt!"
:: Ensure the new name is unique by appending a counter
set "newName=!name:~0,%charPos%!!prefix!!name:~%charPos%!!ext!"
if exist "%folderPath%\!newName!" (
    set "newName=!name:~0,%charPos%!!prefix!!name:~%charPos%!!ext!"
)
ren "%file%" "!newName!"
endlocal
goto :eof

endlocal