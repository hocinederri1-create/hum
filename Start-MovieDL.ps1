# Movie-DL autostart launcher (called by Start-MovieDL.vbs at Windows login).
# Starts the backend and the web app hidden, then opens the browser.
$ErrorActionPreference = "SilentlyContinue"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$env:PATH = "$env:LOCALAPPDATA\Programs\nodejs;$env:PATH"

$backendOn = Get-NetTCPConnection -LocalPort 8000 -State Listen
if (-not $backendOn) {
    Start-Process -FilePath (Join-Path $root ".venv\Scripts\python.exe") `
        -ArgumentList "dev_server.py" -WorkingDirectory (Join-Path $root "backend") -WindowStyle Hidden
}

$frontOn = Get-NetTCPConnection -LocalPort 5173 -State Listen
if (-not $frontOn) {
    Start-Process -FilePath "$env:LOCALAPPDATA\Programs\nodejs\npm.cmd" `
        -ArgumentList "run", "dev" -WorkingDirectory (Join-Path $root "frontend") -WindowStyle Hidden
}

Start-Sleep -Seconds 10
Start-Process "http://127.0.0.1:5173"