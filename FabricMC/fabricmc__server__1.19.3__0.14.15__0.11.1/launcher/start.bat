@echo off

set config=%~1

chcp 65001

rem will change the path where the batch file resides
cd /d %~dp0../server

::===============================================================
:: Read config.properties and extract some data inside variable
::
:: thanks https://stackoverflow.com/questions/7708681/how-to-read-from-a-properties-file-using-batch-script
::===============================================================

for /F "eol=# delims== tokens=1,*" %%a in (../launcher/basic-config.properties) do (
    if NOT "%%a"=="" if NOT "%%b"=="" set args.%%a=%%b
)

IF NOT [%config%]==[] (
    for /F "eol=# delims== tokens=1,*" %%a in (../launcher/%config%.properties) do (
        if NOT "%%a"=="" if NOT "%%b"=="" set args.%%a=%%b
    )
)

set title=%args.title%
set javaBinFolder=%args.javaDir%/bin
set serverJar=%args.serverJar%
set nogui=%args.nogui%

set basicFlags=%args.basicFlags%
set memoryFlags=%args.memoryFlags%
set jvmDebuggerFlags=%args.jvmDebuggerFlags%

set AikarsFlagsLessThan12GB=%args.AikarsFlagsLessThan12GB%
set AikarsFlagsMoreThan12GB=%args.AikarsFlagsMoreThan12GB%
set ShenandoahFlags=%args.ShenandoahFlags%

set gcToUse=%args.gcToUse%

rem -------------------------------------- rem
rem A fun to split a string using a delimiter
set input=%memoryFlags%
set nth=2
for /F "tokens=%nth% delims= " %%a in ("%input%") do set nthstring=%%a
rem echo %nthstring%
rem -------------------------------------- rem

set maxMemoryAsInt=%nthstring:~4,-1%

rem empty by default
set gcFlags=

IF %gcToUse%==Aikars (
    IF %maxMemoryAsInt% GEQ 12288 (
        set gcFlags=%AikarsFlagsMoreThan12GB%
    ) ELSE (
        set gcFlags=%AikarsFlagsLessThan12GB%
    )
)
IF %gcToUse%==Shenandoah (
    echo Shenandoah flags defined
    set gcFlags=%ShenandoahFlags%
)

title %title%

set commandline="../%javaBinFolder%/java.exe" -jar %basicFlags% %memoryFlags% %jvmDebuggerFlags% %gcFlags% %serverJar%

rem set commandline=%commandline% %gcFlags% %serverJar%

if %nogui%==true set commandline=%commandline% nogui

:loop

echo "commandline is %commandline%"
rem pause

%commandline%

timeout /t 30 /nobreak

goto loop
