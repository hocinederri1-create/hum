@echo off
REM ============================================================
REM  Movie Downloader - one-click launcher
REM  Starts the backend server + the web app, then opens your
REM  browser. Close the two small windows to stop everything.
REM ============================================================
setlocal
set ROOT=%~dp0
set PATH=%LOCALAPPDATA%\Programs\nodejs;%PATH%

echo Starting backend (Movie-DL Server)...
start "Movie-DL Backend" /min cmd /c "cd /d ""%ROOT%backend"" && ""%ROOT%.venv\Scripts\python.exe"" dev_server.py"

echo Starting web app (Movie-DL Frontend)...
start "Movie-DL Frontend" /min cmd /c "cd /d ""%ROOT%frontend"" && npm.cmd run dev"

echo Opening browser in a few seconds...
timeout /t 8 /nobreak >NUL
start "" http://127.0.0.1:5173

echo.
echo All started. Log in with:  admin / admin
echo Your browser should open automatically at http://127.0.0.1:5173
echo Close the two "Movie-DL" windows to stop everything.
echo.
pause
endlocal