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
set "bitrate=%~3"

:: If no output folder is provided, use the input folder
if "%outputFolder%"=="" set "outputFolder=%inputFolder%"

:: If no bitrate is provided, use the default of 228k
if "%bitrate%"=="" set "bitrate=228k"

:: Create the output folder if it does not exist
if not exist "%outputFolder%" mkdir "%outputFolder%"

:: Convert all .wav, .flac, .m4a, and .mp4 files to .mp3
for %%a in ("%inputFolder%\*.wav" "%inputFolder%\*.flac" "%inputFolder%\*.m4a" "%inputFolder%\*.mp4") do (
    ffmpeg -i "%%a" -b:a %bitrate% "%outputFolder%\%%~na.mp3"
)

echo Conversion complete.

endlocal