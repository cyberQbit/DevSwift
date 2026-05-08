:: ==============================================================================
:: [⚡] DEVSWIFT PRO v3.0 - DYNAMIC JSON ENGINE (Zero-Footprint)
:: ==============================================================================
@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

set "PSFILE=%PROGRAMDATA%\cyberQbit\devswift_engine.ps1"

>> "%PSFILE%" echo $ErrorActionPreference = 'SilentlyContinue'
>> "%PSFILE%" echo [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
>> "%PSFILE%" echo Clear-Host
>> "%PSFILE%" echo Write-Host "`n   [⚡] DEVSWIFT PRO - DYNAMIC PACKAGE MANAGER" -ForegroundColor Yellow
>> "%PSFILE%" echo Write-Host "   ===============================================================" -ForegroundColor DarkGray
>> "%PSFILE%" echo Write-Host "   [*] Bulut veritabanina baglaniliyor (apps.json)..." -ForegroundColor Cyan
>> "%PSFILE%" echo.
>> "%PSFILE%" echo $jsonUrl = "https://raw.githubusercontent.com/cyberQbit/DevSwift/main/apps.json?t=$((Get-Date).Ticks)"
>> "%PSFILE%" echo $jsonResponse = Invoke-RestMethod -Uri $jsonUrl
>> "%PSFILE%" echo $categories = $jsonResponse.psobject.properties.name
>> "%PSFILE%" echo.
>> "%PSFILE%" echo $allApps = @()
>> "%PSFILE%" echo $counter = 1
>> "%PSFILE%" echo foreach ($cat in $categories) {
>> "%PSFILE%" echo     Write-Host "   --- $cat ---" -ForegroundColor Green
>> "%PSFILE%" echo     foreach ($app in $jsonResponse.$cat) {
>> "%PSFILE%" echo         Write-Host "   [$counter] $($app.Name)" -ForegroundColor White
>> "%PSFILE%" echo         $allApps += [PSCustomObject]@{ Index = $counter; Name = $app.Name; Id = $app.Id }
>> "%PSFILE%" echo         $counter++
>> "%PSFILE%" echo     }
>> "%PSFILE%" echo     Write-Host ""
>> "%PSFILE%" echo }
>> "%PSFILE%" echo Write-Host "   ===============================================================" -ForegroundColor DarkGray
>> "%PSFILE%" echo Write-Host "   [+] Kurmak istediginiz programlarin numaralarini bosluk birakarak yazin." -ForegroundColor Yellow
>> "%PSFILE%" echo Write-Host "       (Ornek: 1 4 5 12)" -ForegroundColor DarkGray
>> "%PSFILE%" echo Write-Host "   [0] Iptal ve Ana Menuye Don" -ForegroundColor Red
>> "%PSFILE%" echo Write-Host ""
>> "%PSFILE%" echo $choices = Read-Host "   Seciminiz"
>> "%PSFILE%" echo if ($choices -eq '0') { exit }
>> "%PSFILE%" echo.
>> "%PSFILE%" echo $selectedNumbers = $choices -split ' ' ^| Where-Object { $_ -match '^\d+$' }
>> "%PSFILE%" echo $toInstall = $allApps ^| Where-Object { $selectedNumbers -contains $_.Index }
>> "%PSFILE%" echo.
>> "%PSFILE%" echo if ($toInstall.Count -gt 0) {
>> "%PSFILE%" echo     Write-Host "   [!] Secilen $($toInstall.Count) program kuruluyor... Lutfen bekleyin.`n" -ForegroundColor Cyan
>> "%PSFILE%" echo     foreach ($item in $toInstall) {
>> "%PSFILE%" echo         Write-Host "   [-] Kuruluyor: $($item.Name) ($($item.Id))" -ForegroundColor Blue
>> "%PSFILE%" echo         Start-Process -FilePath "winget" -ArgumentList "install --id $($item.Id) --accept-source-agreements --accept-package-agreements --silent" -Wait -NoNewWindow
>> "%PSFILE%" echo         Write-Host "   [OK] $($item.Name) Kurulumu Tamamlandi!`n" -ForegroundColor Green
>> "%PSFILE%" echo     }
>> "%PSFILE%" echo     Write-Host "   [+] TUM KURULUMLAR KUSURSUZCA TAMAMLANDI!" -ForegroundColor Yellow
>> "%PSFILE%" echo } else {
>> "%PSFILE%" echo     Write-Host "   [X] Gecerli bir secim yapilamadi." -ForegroundColor Red
>> "%PSFILE%" echo }
>> "%PSFILE%" echo.
>> "%PSFILE%" echo Write-Host "   Devam etmek icin [ENTER] tusuna basin..." -ForegroundColor DarkGray
>> "%PSFILE%" echo Read-Host
>> "%PSFILE%" echo exit

powershell -NoProfile -ExecutionPolicy Bypass -File "%PSFILE%"
del /q "%PSFILE%" >nul 2>&1
exit