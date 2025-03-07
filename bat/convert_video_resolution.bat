@echo off
setlocal enabledelayedexpansion

:: Display help if no parameters or help is requested
if "%~1"=="" goto :help
if /i "%~1"=="--help" goto :help
if /i "%~1"=="-h" goto :help

:: Get the input file
set "inputFile=%~1"
set "resolution=%~2"
set "outputFolder=%~3"
set "preset="

:: Check if input file exists
if not exist "%inputFile%" (
    echo Error: Input file "%inputFile%" not found.
    goto :help
)

:: If no output folder is provided, use the current directory
if "%outputFolder%"=="" set "outputFolder=%~dp1"

:: Create the output folder if it does not exist
if not exist "%outputFolder%" mkdir "%outputFolder%"

:: Handle preset resolutions or custom resolution
if /i "%resolution%"=="1080p" (
    set "width=1920"
    set "height=1080"
    set "preset=1080p"
) else if /i "%resolution%"=="720p" (
    set "width=1280"
    set "height=720"
    set "preset=720p"
) else if /i "%resolution%"=="480p" (
    set "width=854"
    set "height=480"
    set "preset=480p"
) else if /i "%resolution%"=="360p" (
    set "width=640"
    set "height=360"
    set "preset=360p"
) else (
    :: Check for custom resolution in format WIDTHxHEIGHT
    for /f "tokens=1,2 delims=x" %%a in ("%resolution%") do (
        set "width=%%a"
        set "height=%%b"
    )

    :: Validate custom resolution
    if "%height%"=="" (
        echo Error: Invalid resolution format.
        goto :help
    )
)

:: Generate output filename
set "filename=%~n1"
set "extension=%~x1"
if defined preset (
    set "outputFile=%outputFolder%\%filename%_%preset%%extension%"
) else (
    set "outputFile=%outputFolder%\%filename%_%width%x%height%%extension%"
)

echo Converting "%inputFile%" to %width%x%height% resolution...
echo Output: "%outputFile%"

:: Run ffmpeg to convert the video
ffmpeg -i "%inputFile%" -vf "scale=%width%:%height%" -c:a copy "%outputFile%"

echo Conversion complete.
goto :eof

:help
echo.
echo Video Resolution Converter Script
echo ================================
echo.
echo Usage: %~nx0 input_file resolution [output_folder]
echo.
echo Parameters:
echo   input_file    - The video file to convert (supports mp4 and other formats)
echo   resolution    - Target resolution, can be a preset or custom format:
echo                   Presets: 1080p, 720p, 480p, 360p
echo                   Custom format: WIDTHxHEIGHT (e.g., 1280x720)
echo   output_folder - Optional. Folder to save the converted video
echo                   If not specified, uses the input file's folder
echo.
echo Examples:
echo   %~nx0 video.mp4 720p
echo   %~nx0 video.mp4 1280x720 D:\converted_videos
echo.
exit /b 1

endlocal
