@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1

:: ===========================
::     DevSwift Pro v2.0 
:: ===========================

title DevSwift Pro v2.0 - cyberQbit Terminal Ekosistemi
color 0F
mode con: cols=100 lines=40

:: Renk Kodlari
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "GREEN=%ESC%[92m"
set "RED=%ESC%[91m"
set "YELLOW=%ESC%[93m"
set "CYAN=%ESC%[96m"
set "WHITE=%ESC%[97m"
set "GRAY=%ESC%[90m"
set "RESET=%ESC%[0m"

:Initialize
pushd "%CD%"
CD /D "%~dp0"
set "LANG_FILE=%APPDATA%\DevSwift_Lang.ini"
set "LOG_FILE=%APPDATA%\DevSwift_Log.txt"

if exist "%LANG_FILE%" (
    set /p LANG=<"%LANG_FILE%"
    goto :SetStrings
)

:SelectLanguage
cls
echo.
echo %CYAN%======================================================================================%RESET%
echo %CYAN%                   ___             ___         _  __  _                                 %RESET%
echo %CYAN%                  / _ \ ___ _  __ / __/_    _ (_)/ _/^| ^|_                             %RESET%
echo %CYAN%                 / // // -_) ^|/ /_\ \ ^| ^|/^|/ / // _/ ^|  _^|                        %RESET%
echo %CYAN%                /____/ \__/^|___//___/ ^|__,__/_//_/    \__^|                           %RESET%
echo %CYAN%                                                                                        %RESET%
echo %CYAN%======================================================================================%RESET%
echo.
echo %YELLOW%                 *** THE ULTIMATE SETUP ENGINE ***%RESET%
echo %YELLOW%                Windows 10/11 Developer Environment%RESET%
echo.
echo   [1] English
echo   [2] Turkce
echo.
choice /c 12 /n /m "%CYAN%Please select your language / Lutfen dil secin (1-2): %RESET%"
if "!errorlevel!"=="2" ( set "LANG=TR" ) else ( set "LANG=EN" )
echo !LANG!>"%LANG_FILE%"

:SetStrings
if "!LANG!"=="TR" (
    set "S_VER=Versiyon"
    set "S_DEV=Gelistirici"
    set "S_M1=[1] Minimal Profil     (Git, VS Code, Chrome)"
    set "S_M2=[2] Developer Profil   (Git, Node, Python, Docker, Postman, VS Code)"
    set "S_M3=[3] Creative Profil    (Blender, GIMP, Inkscape, Audacity, OBS)"
    set "S_M4=[4] Gamer Profil       (Steam, Epic, Discord, VLC)"
    set "S_M5=[5] Professional       (Tum araclar + Microsoft + Office)"
    set "S_M6=[6] Full Suite         (HER SEYI KUR!)"
    set "S_M7=[7] Ozel Secim         (50+ aractan istediklerini manuel sec)"
    set "S_M8=[8] Proje Klasorleri   (C:\Projects hiyerarsisini olustur)"
    set "S_M9=[9] Sistemi Guncelle   (Winget ile tum programlari guncelle)"
    set "S_ML=[L] Dili Degistir      (Change Language)"
    set "S_M0=[0] Cikis"
    set "S_PRMPT=Lutfen bir profil veya islem secin"
    set "S_BACK=Ana menuye donmek icin bir tusa basin"
) else (
    set "S_VER=Version"
    set "S_DEV=Developer"
    set "S_M1=[1] Minimal Profile    (Git, VS Code, Chrome)"
    set "S_M2=[2] Developer Profile  (Git, Node, Python, Docker, Postman, VS Code)"
    set "S_M3=[3] Creative Profile   (Blender, GIMP, Inkscape, Audacity, OBS)"
    set "S_M4=[4] Gamer Profile      (Steam, Epic, Discord, VLC)"
    set "S_M5=[5] Professional       (All dev tools + Microsoft + Office)"
    set "S_M6=[6] Full Suite         (INSTALL EVERYTHING!)"
    set "S_M7=[7] Custom Selection   (Pick manually from 50+ tools)"
    set "S_M8=[8] Project Folders    (Create C:\Projects hierarchy)"
    set "S_M9=[9] Update System      (Upgrade all apps via Winget)"
    set "S_ML=[L] Change Language    (Dili Degistir)"
    set "S_M0=[0] Exit"
    set "S_PRMPT=Please select a profile or action"
    set "S_BACK=Press any key to return to main menu"
)

:MainMenu
cls
echo.
echo %CYAN%======================================================================================%RESET%
echo %CYAN%                   ___             ___         _  __  _                                 %RESET%
echo %CYAN%                  / _ \ ___ _  __ / __/_    _ (_)/ _/^| ^|_                             %RESET%
echo %CYAN%                 / // // -_) ^|/ /_\ \ ^| ^|/^|/ / // _/ ^|  _^|                        %RESET%
echo %CYAN%                /____/ \__/^|___//___/ ^|__,__/_//_/    \__^|                           %RESET%
echo %CYAN%                                                                                        %RESET%
echo %CYAN%======================================================================================%RESET%
echo.
echo %YELLOW%  !S_VER!: 2.0  ^|  !S_DEV!: cyberQbit  ^|  Platform: Windows 10/11%RESET%
echo %GRAY%  ----------------------------------------------------------------------------------%RESET%
echo.
echo   !S_M1!
echo   !S_M2!
echo   !S_M3!
echo   !S_M4!
echo   !S_M5!
echo   !S_M6!
echo.
echo   !S_M7!
echo   !S_M8!
echo   !S_M9!
echo.
echo   !S_ML!
echo   !S_M0!
echo.
echo %GRAY%  ----------------------------------------------------------------------------------%RESET%
echo.
choice /c 123456789L0 /n /m "%CYAN%!S_PRMPT!: %RESET%"
set "menu=!errorlevel!"

if "!menu!"=="11" goto :EOF
if "!menu!"=="10" ( del "%LANG_FILE%" & goto :SelectLanguage )
if "!menu!"=="9" goto :UpdateSystem
if "!menu!"=="8" goto :CreateFolders
if "!menu!"=="7" goto :CustomSelection
if "!menu!"=="6" set PROFILE=FULL & goto :ExecuteProfile
if "!menu!"=="5" set PROFILE=PROFESSIONAL & goto :ExecuteProfile
if "!menu!"=="4" set PROFILE=GAMER & goto :ExecuteProfile
if "!menu!"=="3" set PROFILE=CREATIVE & goto :ExecuteProfile
if "!menu!"=="2" set PROFILE=DEVELOPER & goto :ExecuteProfile
if "!menu!"=="1" set PROFILE=MINIMAL & goto :ExecuteProfile
goto :MainMenu

:: ==============================================================================
:: YARDIMCI FONKSIYONLAR
:: ==============================================================================
:PrintSeparator
echo %GRAY%--------------------------------------------------------------------------------%RESET%
goto :eof

:PrintSuccess
set "msg=%~1"
echo %GREEN%[OK] !msg!%RESET%
goto :eof

:InstallTool
set "TOOL_NAME=%~1"
set "WINGET_ID=%~2"
echo.
echo %CYAN%[*] Installing: %TOOL_NAME%...%RESET%
winget install -e --id %WINGET_ID% --silent --accept-package-agreements --accept-source-agreements >nul 2>&1
if %errorlevel% equ 0 (
    call :PrintSuccess "%TOOL_NAME% installed successfully"
) else (
    echo %RED%[X] Failed to install %TOOL_NAME%%RESET%
)
goto :eof

:: ==============================================================================
:: KLASORLER & GUNCELLEME (Folders & Updates)
:: ==============================================================================
:CreateFolders
cls
call :PrintSeparator
echo.
echo %CYAN%[*] Creating Project Directory Structure...%RESET%
echo.

if not exist "C:\Projects" mkdir "C:\Projects"
if not exist "C:\Projects\Personal" mkdir "C:\Projects\Personal"
if not exist "C:\Projects\Work" mkdir "C:\Projects\Work"
if not exist "C:\Projects\Learning" mkdir "C:\Projects\Learning"
if not exist "C:\DevTools" mkdir "C:\DevTools"

call :PrintSuccess "Directories created at C:\Projects"
echo.
echo %CYAN%!S_BACK!%RESET%
pause >nul
goto :MainMenu

:UpdateSystem
cls
call :PrintSeparator
echo.
echo %CYAN%[*] Updating Windows Package Manager Sources...%RESET%
winget source update >nul 2>&1
echo %CYAN%[*] Upgrading all installed applications... (This may take a while)%RESET%
echo.
winget upgrade --all --silent --include-unknown
echo.
call :PrintSuccess "System update complete!"
echo.
echo %CYAN%!S_BACK!%RESET%
pause >nul
goto :MainMenu

:: ==============================================================================
:: PROFIL CALISTIRMA (Profile Execution)
:: ==============================================================================
:ExecuteProfile
cls
call :PrintSeparator
echo.
echo %YELLOW%[*] INITIALIZING PROFILE: %PROFILE%%RESET%
echo.
call :PrintSeparator

if "%PROFILE%"=="MINIMAL" (
    call :InstallTool "Google Chrome" "Google.Chrome"
    call :InstallTool "VS Code" "Microsoft.VisualStudioCode"
    call :InstallTool "Git" "Git.Git"
)

if "%PROFILE%"=="DEVELOPER" (
    call :InstallTool "Google Chrome" "Google.Chrome"
    call :InstallTool "VS Code" "Microsoft.VisualStudioCode"
    call :InstallTool "Git" "Git.Git"
    call :InstallTool "Node.js (LTS)" "OpenJS.NodeJS.LTS"
    call :InstallTool "Python 3" "Python.Python.3"
    call :InstallTool "Docker Desktop" "Docker.DockerDesktop"
    call :InstallTool "Postman" "Postman.Postman"
)

if "%PROFILE%"=="CREATIVE" (
    call :InstallTool "Blender" "BlenderFoundation.Blender"
    call :InstallTool "GIMP" "GNU.ImageManipulationProgram"
    call :InstallTool "Inkscape" "Inkscape.Inkscape"
    call :InstallTool "Audacity" "AudacityTeam.Audacity"
    call :InstallTool "OBS Studio" "OBSProject.OBSStudio"
)

if "%PROFILE%"=="GAMER" (
    call :InstallTool "Steam" "Valve.Steam"
    call :InstallTool "Epic Games" "EpicGames.EpicGamesLauncher"
    call :InstallTool "Discord" "Discord.Discord"
    call :InstallTool "VLC Media Player" "VideoLAN.VLC"
)

if "%PROFILE%"=="PROFESSIONAL" (
    call :InstallTool "Google Chrome" "Google.Chrome"
    call :InstallTool "VS Code" "Microsoft.VisualStudioCode"
    call :InstallTool "Git" "Git.Git"
    call :InstallTool "Node.js (LTS)" "OpenJS.NodeJS.LTS"
    call :InstallTool "Python 3" "Python.Python.3"
    call :InstallTool "Docker Desktop" "Docker.DockerDesktop"
    call :InstallTool "Windows Terminal" "Microsoft.WindowsTerminal"
    call :InstallTool "PowerShell 7" "Microsoft.PowerShell"
    call :InstallTool "7-Zip" "7zip.7zip"
    call :InstallTool "Slack" "Slack.Slack"
    call :InstallTool "Zoom" "Zoom.Zoom"
)

if "%PROFILE%"=="FULL" (
    echo %RED%[!] Installing FULL SUITE. Go grab a coffee...%RESET%
    call :InstallTool "Google Chrome" "Google.Chrome"
    call :InstallTool "Firefox" "Mozilla.Firefox"
    call :InstallTool "VS Code" "Microsoft.VisualStudioCode"
    call :InstallTool "Git" "Git.Git"
    call :InstallTool "Node.js (LTS)" "OpenJS.NodeJS.LTS"
    call :InstallTool "Python 3" "Python.Python.3"
    call :InstallTool "Docker Desktop" "Docker.DockerDesktop"
    call :InstallTool "Postman" "Postman.Postman"
    call :InstallTool "DBeaver" "dbeaver.dbeaver"
    call :InstallTool "Windows Terminal" "Microsoft.WindowsTerminal"
    call :InstallTool "PowerShell 7" "Microsoft.PowerShell"
    call :InstallTool "Discord" "Discord.Discord"
    call :InstallTool "Slack" "Slack.Slack"
    call :InstallTool "VLC Media Player" "VideoLAN.VLC"
    call :InstallTool "OBS Studio" "OBSProject.OBSStudio"
    call :InstallTool "7-Zip" "7zip.7zip"
    call :InstallTool "Everything Search" "voidtools.Everything"
)

echo.
call :PrintSeparator
call :PrintSuccess "PROFILE INSTALLATION COMPLETE!"
call :PrintSeparator
echo.
echo %CYAN%!S_BACK!%RESET%
pause >nul
goto :MainMenu

:: ==============================================================================
:: CUSTOM SELECTION (TUI)
:: ==============================================================================
:CustomSelection
cls
call :PrintSeparator
echo %YELLOW%  CUSTOM SELECTION (Enter numbers separated by space, e.g., 01 11 40)%RESET%
call :PrintSeparator
echo.
echo %CYAN%[ BROWSERS ]%RESET%
echo  01. Chrome       02. Firefox      03. Edge         04. Brave
echo.
echo %CYAN%[ DEV TOOLS ]%RESET%
echo  10. Git          11. VS Code      12. Node.js      13. Python 3
echo  14. Docker       15. Postman      16. DBeaver      17. Sublime Text
echo.
echo %CYAN%[ COMM & MEDIA ]%RESET%
echo  20. Discord      21. Slack        22. Zoom         23. Telegram
echo  30. VLC          31. Audacity     32. OBS Studio   33. HandBrake
echo.
echo %CYAN%[ SYSTEM & UTILS ]%RESET%
echo  40. 7-Zip        41. WinRAR       42. Win Terminal 43. PowerShell
echo  44. Notepad++    45. Everything   46. TreeSize     47. Rufus
echo.
echo %CYAN%[ GAMING & DESIGN ]%RESET%
echo  50. Steam        51. Epic Games   52. Blender      53. GIMP
echo.
set /p custom_choice="%YELLOW%Selection: %RESET%"

if "%custom_choice%"=="" goto :MainMenu

echo.
echo %CYAN%[*] Starting custom installation batch...%RESET%

for %%i in (%custom_choice%) do (
    if "%%i"=="01" call :InstallTool "Chrome" "Google.Chrome"
    if "%%i"=="02" call :InstallTool "Firefox" "Mozilla.Firefox"
    if "%%i"=="03" call :InstallTool "Edge" "Microsoft.Edge"
    if "%%i"=="04" call :InstallTool "Brave" "BraveSoftware.BraveBrowser"
    if "%%i"=="10" call :InstallTool "Git" "Git.Git"
    if "%%i"=="11" call :InstallTool "VS Code" "Microsoft.VisualStudioCode"
    if "%%i"=="12" call :InstallTool "Node.js" "OpenJS.NodeJS.LTS"
    if "%%i"=="13" call :InstallTool "Python 3" "Python.Python.3"
    if "%%i"=="14" call :InstallTool "Docker" "Docker.DockerDesktop"
    if "%%i"=="15" call :InstallTool "Postman" "Postman.Postman"
    if "%%i"=="16" call :InstallTool "DBeaver" "dbeaver.dbeaver"
    if "%%i"=="17" call :InstallTool "Sublime Text" "SublimeHQ.SublimeText.4"
    if "%%i"=="20" call :InstallTool "Discord" "Discord.Discord"
    if "%%i"=="21" call :InstallTool "Slack" "Slack.Slack"
    if "%%i"=="22" call :InstallTool "Zoom" "Zoom.Zoom"
    if "%%i"=="23" call :InstallTool "Telegram" "Telegram.TelegramDesktop"
    if "%%i"=="30" call :InstallTool "VLC" "VideoLAN.VLC"
    if "%%i"=="31" call :InstallTool "Audacity" "AudacityTeam.Audacity"
    if "%%i"=="32" call :InstallTool "OBS Studio" "OBSProject.OBSStudio"
    if "%%i"=="33" call :InstallTool "HandBrake" "HandBrake.HandBrake"
    if "%%i"=="40" call :InstallTool "7-Zip" "7zip.7zip"
    if "%%i"=="41" call :InstallTool "WinRAR" "RARLab.WinRAR"
    if "%%i"=="42" call :InstallTool "Windows Terminal" "Microsoft.WindowsTerminal"
    if "%%i"=="43" call :InstallTool "PowerShell" "Microsoft.PowerShell"
    if "%%i"=="44" call :InstallTool "Notepad++" "Notepad++.Notepad++"
    if "%%i"=="45" call :InstallTool "Everything" "voidtools.Everything"
    if "%%i"=="46" call :InstallTool "TreeSize" "JAM-Software.TreeSize"
    if "%%i"=="47" call :InstallTool "Rufus" "Rufus.Rufus"
    if "%%i"=="50" call :InstallTool "Steam" "Valve.Steam"
    if "%%i"=="51" call :InstallTool "Epic Games" "EpicGames.EpicGamesLauncher"
    if "%%i"=="52" call :InstallTool "Blender" "BlenderFoundation.Blender"
    if "%%i"=="53" call :InstallTool "GIMP" "GNU.ImageManipulationProgram"
)

echo.
call :PrintSeparator
call :PrintSuccess "CUSTOM INSTALLATION COMPLETE!"
call :PrintSeparator
echo.
echo %CYAN%!S_BACK!%RESET%
pause >nul
goto :MainMenu

:EOF
cls
echo.
echo %YELLOW%  Thank you for using DevSwift Pro v2.0!%RESET%
echo %GRAY%  Developed by cyberQbit %RESET%
timeout /t 3 /nobreak >nul
exit