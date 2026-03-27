# ==============================================================================
# DevSwift Pro - Yönetici Yetkisi Kontrolü ve Güvenli İndirme Motoru
# ==============================================================================

Write-Host ""
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "                 DevSwift Pro - Baslatiliyor                          " -ForegroundColor Cyan
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host ""

# Yönetici yetkisi kontrolü
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[!] DevSwift, program kurabilmek icin Yonetici iznine ihtiyac duyar." -ForegroundColor Yellow
    Write-Host "[*] Lutfen UAC penceresinde 'Evet' secenegini tiklayin." -ForegroundColor White
    Write-Host ""

    try {
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/cyberQbit/DevSwift/main/run.ps1 | iex`"" -Verb RunAs
    } catch {
        Write-Host "[X] Yonetici yetkileri alinamadi!" -ForegroundColor Red
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    exit
}

Write-Host "[OK] Yonetici yetkileri dogrulandi!" -ForegroundColor Green
Write-Host "[*] DevSwift motoru indiriliyor..." -ForegroundColor Cyan

# Aracı indir ve LF->CRLF format dönüşümünü zorla (Çökmeleri engeller)
$batPath = "$env:TEMP\DevSwift.bat"
try {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/cyberQbit/DevSwift/main/DevSwift.bat" -OutFile $batPath -UseBasicParsing
    
    # === LINUX (LF) FORMATINI WINDOWS (CRLF) FORMATINA ZORLA VE BOM'U YOK ET ===
    $content = Get-Content $batPath -Raw
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($batPath, $content, $utf8NoBom)
    
    Write-Host "[OK] Motor basariyla hazirlandi!" -ForegroundColor Green
    Write-Host "[*] Arayuz aciliyor..." -ForegroundColor Cyan
    Start-Sleep -Milliseconds 500
    Start-Process -FilePath $batPath -Wait
} catch {
    Write-Host "[X] DevSwift indirilemedi! Baglantinizi kontrol edin." -ForegroundColor Red
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
