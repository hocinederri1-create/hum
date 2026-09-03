' Wrapper so the launcher runs hidden at login, no terminal window, no Execution-Policy error.
Set sh = CreateObject("WScript.Shell")
script = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\")) & "Start-MovieDL.ps1"
sh.Run "powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & script & """", 0, False