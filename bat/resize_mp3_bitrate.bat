@echo off
setlocal enabledelayedexpansion

:: Check for input folder
if "%~1"=="" (
    echo Please specify an input folder.
    exit /b 1
)

:: Set input folder and bitrate
set "inputFolder=%~1"
set "bitrate=%~2"

:: If no bitrate is provided, use the default of 228k
if "%bitrate%"=="" set "bitrate=228k"

:: Extract numeric part of bitrate for filename
set "bitrateNum=%bitrate:"=%"
set "bitrateNum=%bitrateNum:k=%"

:: Resize all .mp3 files to specified bitrate
for %%a in ("%inputFolder%\*.mp3") do (
    set "outputFile=%%~dpa%%~na_%bitrateNum%%%~xa"
    ffmpeg -i "%%a" -b:a %bitrate% "!outputFile!"
)

echo Conversion complete.

endlocal