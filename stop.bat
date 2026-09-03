@echo off
REM Stops the Movie Downloader servers (backend + frontend).
REM Kills any python running dev_server.py and any node/vite from this project.
setlocal
powershell -NoProfile -Command ^
  "Get-CimInstance Win32_Process | Where-Object { ($_.Name -eq 'python.exe' -and $_.CommandLine -like '*dev_server.py*') -or ($_.Name -eq 'node.exe' -and $_.CommandLine -like '*wibesite movies*') } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"
echo Stopped. Close the browser tab if it is still open.
pause
endlocal