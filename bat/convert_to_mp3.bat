@echo off
setlocal enabledelayedexpansion

:: Check for input folder
if "%~1"=="" (
    echo Please specify an input folder.
    exit /b 1
)

:: Set input and output folders
set "inputFolder=%~1"
set "outputFolder=%~2"

:: If no output folder is provided, use the input folder
if "%~2"=="" set "outputFolder=%~1"

:: Create the output folder if it does not exist
if not exist "%outputFolder%" mkdir "%outputFolder%"

:: Convert all .wav and .flac files to .mp3
for %%a in ("%inputFolder%\*.wav" "%inputFolder%\*.flac" "%inputFolder%\*.m4a" "%inputFolder%\*.mp4") do (
    ffmpeg -i "%%a" -q:a 0 "%outputFolder%\%%~na.mp3"
)

echo Conversion complete.

endlocal