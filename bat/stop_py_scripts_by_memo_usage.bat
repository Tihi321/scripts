@echo off
setlocal EnableDelayedExpansion

echo Listing all python.exe processes:
tasklist /FI "IMAGENAME eq python.exe"

echo.
set /p minMem=Enter minimum memory usage in K (default 9000): 
if "%minMem%"=="" set minMem=9000

set /p maxMem=Enter maximum memory usage in K (default 20000): 
if "%maxMem%"=="" set maxMem=20000

echo.
echo Listing and stopping python.exe processes with memory usage between %minMem%K and %maxMem%K:

for /f "tokens=1,2,3,4,5" %%a in ('tasklist /FI "IMAGENAME eq python.exe" /NH') do (
    set memUsage=%%e
    set memUsage=!memUsage:K=!
    set memUsage=!memUsage:,=!
    if !memUsage! geq %minMem% if !memUsage! leq %maxMem% (
        echo Stopping process: %%a %%b %%c %%d %%e
        taskkill /PID %%b /F
    )
)

pause
endlocal