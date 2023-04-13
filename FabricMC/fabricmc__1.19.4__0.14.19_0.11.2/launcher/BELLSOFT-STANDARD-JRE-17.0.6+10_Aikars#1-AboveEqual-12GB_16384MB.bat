cd /d %~dp0../server

chcp 65001

:loop
"C:\temp\avril-2023-serverGeneratorTest\fabricmc__1.19.4__0.14.19_0.11.2\java\bellsoft\jre-17.0.6\bin\java.exe" -Xms16384M -Xmx16384M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+DisableExplicitGC -XX:+PerfDisableSharedMem -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1ReservePercent=15 -XX:G1HeapRegionSize=16M -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true  -server -Dfile.encoding=UTF-8 -jar "fabric-server-mc.1.19.4-loader.0.14.19-launcher.0.11.2.jar" --nogui

echo Restarting the server in 30 seconds. Press Ctrl+C to stop
timeout /t 30 /nobreak
goto loop