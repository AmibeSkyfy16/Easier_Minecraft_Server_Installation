cd /d %~dp0../server

chcp 65001

:loop
"C:\temp\avril-2023-serverGeneratorTest\fabricmc__1.19.4__0.14.19_0.11.2\java\bellsoft\jre-17.0.6\bin\java.exe" -Xms8192M -Xmx8192M  -server -Dfile.encoding=UTF-8 -jar "fabric-server-mc.1.19.4-loader.0.14.19-launcher.0.11.2.jar" --nogui

echo Restarting the server in 30 seconds. Press Ctrl+C to stop
timeout /t 30 /nobreak
goto loop