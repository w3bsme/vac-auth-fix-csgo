@echo off
title VAC Auth Softfix
echo ----------
echo Starting...
echo ----------
Set "SExe="
Set "SPth="
For /F "Tokens=1,2*" %%A In ('Reg Query HKCU\SOFTWARE\Valve\Steam') Do (
    If "%%A" Equ "SteamExe" Set "SExe=%%C"
    If "%%A" Equ "SteamPath" Set "SPth=%%C")
If Not Defined SExe Exit/B
tasklist | find /i "csgo.exe" && taskkill /im csgo.exe /F /IM || echo CSGO not running.
echo ----------
echo Stopping Steam...
echo ----------
tasklist | find /i "%SExe%" && %SPth%\%SExe% -shutdown && timeout 10 >nul || echo Steam not running.
echo ----------
echo Killing Steam...
echo ----------
taskkill /f /t /im Steam.exe
taskkill /f /t /im SteamService.exe
taskkill /f /t /im steamwebhelper.exe
taskkill /f /t /im GameOverlayUI.exe
taskkill /f /t /im streaming_client.exe
taskkill /f /t /im steamerrorreporter.exe
taskkill /f /t /im steamerrorreporter64.exe
taskkill /f /t /im x86launcher.exe
taskkill /f /t /im x64launcher.exe
taskkill /f /t /im html5app_steam.exe
echo ----------
echo Repairing Steam Service
echo ----------
"%SPth%\bin\SteamService.exe" /repair
echo Finished
echo ----------
pause
