@echo off
setlocal enabledelayedexpansion

REM -- Paths
set "inputFile=list.txt"
set "outputFile=vehicles.lua"

REM -- Check if input file exists
if not exist "%inputFile%" (
    echo Input file %inputFile% not found!
    timeout /t 2 >nul
    exit /b 1
)

REM -- Clear output file or create it if it doesn't exist
echo -- Vehicles list > "%outputFile%"
echo return { >> "%outputFile%"

echo Processing vehicles...

REM -- Start appending to the Lua file
for /f "tokens=*" %%i in (%inputFile%) do (
    set "model=%%i"
    set "name=!model:~0,1!!model:~1!"
    set "defaultPrice=1000000000"
    set "defaultExtraField="
    
    REM -- Output the current vehicle being processed
    echo Adding vehicle: model=!model!, name=!name!
    
    REM -- Append the new vehicle entry to the Lua file
    echo     ["!model!"] = {"!name!", !defaultPrice!, "!defaultExtraField!"}, >> "%outputFile%"
)

echo } >> "%outputFile%"

echo Vehicles have been added to %outputFile%.

REM -- Wait for 10 seconds before closing
timeout /t 10 >nul
