@echo off

chcp 65001

rem will change the path where the batch file resides
cd /d %~dp0../server

::===============================================================
:: Read config.properties and extract some data inside variable
::
:: thanks https://stackoverflow.com/questions/7708681/how-to-read-from-a-properties-file-using-batch-script
::===============================================================

for /F "eol=# delims== tokens=1,*" %%a in (../launcher/config-Shenandoah_8GB.properties) do (
    if NOT "%%a"=="" if NOT "%%b"=="" set args.%%a=%%b
)

set title=%args.title%
set javaBinFolder=%args.javaDir%/bin
set nogui=%args.nogui%
set jvmDebugger=%args.jvmDebugger%
set jvmArgs=%args.jvmArgs%

title %title%

set commandline="../%javaBinFolder%/java.exe" -jar %jvmArgs%

if not %jvmDebugger%=="" set commandline=%commandline% %jvmDebugger%

set commandline=%commandline% "../fabric-server-mc.1.19.3-loader.0.14.12-launcher.0.11.1.jar"

if %nogui%==true set commandline=%commandline% nogui

:loop

echo "commandline is %commandline%"

%commandline%

timeout /t 30 /nobreak

goto loop
