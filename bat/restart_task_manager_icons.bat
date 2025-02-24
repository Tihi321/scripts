@echo off
setlocal enabledelayedexpansion

echo Closing Explorer...
taskkill /F /IM explorer.exe
timeout /t 2 /nobreak > nul

echo Step 1/4: Clearing IconCache.db...
del /f /q "%localappdata%\IconCache.db" 2>nul
if exist "%localappdata%\IconCache.db" (echo Failed clearing IconCache.db) else (echo Cleared IconCache.db)
timeout /t 1 /nobreak > nul

echo Step 2/4: Clearing Explorer icon cache...
start /wait cmd /c del /f /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*" 2>nul
if !errorlevel! neq 0 (echo Warning: Some files may be locked) else (echo Cleared icon cache files)
timeout /t 1 /nobreak > nul

echo Step 3/4: Clearing thumbnail cache...
start /wait cmd /c del /f /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache*" 2>nul
if !errorlevel! neq 0 (echo Warning: Some files may be locked) else (echo Cleared thumbnail cache)
timeout /t 1 /nobreak > nul

echo Step 4/4: Refreshing system icons...
start /wait ie4uinit.exe -show
if !errorlevel! neq 0 (echo Warning: ie4uinit show failed) else (echo System icons refreshed)

echo Starting Explorer...
start explorer.exe

echo Refreshing shell...
%windir%\System32\cmd.exe /c "echo y|regsvr32 /s %windir%\System32\shell32.dll"
%windir%\System32\cmd.exe /c "echo y|regsvr32 /s %windir%\System32\imageres.dll"

echo Process completed.
echo Note: If task manager icons are still incorrect, you may need to restart the computer.
pause