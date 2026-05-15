param(
    [Parameter(Mandatory=$true)]
    [string]$TargetFile # Теперь передаем ПОЛНЫЙ путь, например: "H:\Загрузки\Документ.pdf"
)

$RepoPath = "C:\Evidence"

# 0. Авторизация A©t0r
$SecureTrigger = Read-Host -Prompt "Введите секретное слово для подписи" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureTrigger)
$TriggerWord = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
if ($TriggerWord -cne "База Данных") { Write-Host "[ DENIED ]" -ForegroundColor Red; return }

if (-not (Test-Path $TargetFile)) { Write-Host "[ ERROR ] Файл не найден: $TargetFile" -ForegroundColor Red; return }

# 1. Извлечение хэша НАПРЯМУЮ из источника (БЕЗ копирования на диск C)
$sha = (Get-FileHash -Path $TargetFile -Algorithm SHA256).Hash.ToUpper()
$FileName = Split-Path $TargetFile -Leaf
Write-Host "[*] Хэш вычислен (Zero-Copy): $sha" -ForegroundColor DarkGray

# 2. Прямая выгрузка в облако через WSL
Write-Host "[*] Прямая выгрузка бинарного потока в EvidenceVault..." -ForegroundColor Yellow
$wslPath = ($TargetFile -replace '^([A-Za-z]):', '/mnt/$1' -replace '\\', '/').Substring(0,6).ToLowerInvariant() + ($TargetFile -replace '^([A-Za-z]):', '/mnt/$1' -replace '\\', '/').Substring(6)
wsl rclone copyto "$wslPath" "gdrive:EvidenceVault/$FileName" --progress

# 3. Точечная запись в реестр (эмуляция Update+Resolve)
$RegPath = "C:\Evidence\hash_registry.json"
$registry = Get-Content $RegPath -Raw | ConvertFrom-Json

Write-Host "[*] Запрос ID из облака..." -ForegroundColor DarkGray
$cloudFiles = wsl rclone lsjson gdrive:EvidenceVault --files-only | ConvertFrom-Json
$matchedFile = $cloudFiles | Where-Object { $_.Name -eq $FileName }

if ($matchedFile) {
    $registry | Add-Member -MemberType NoteProperty -Name $sha -Value "https://drive.google.com/uc?id=$($matchedFile.ID)&export=download" -Force
    $registry | ConvertTo-Json -Depth 10 | Set-Content $RegPath -Encoding UTF8
    Write-Host "[ OK ] Ссылка жестко зафиксирована в реестре." -ForegroundColor Green
} else {
    Write-Host "[!] Облако еще не обработало файл. Повторите резолвинг позже." -ForegroundColor Red
}

# 4. Формирование манифеста в Штабе (C:\Evidence)
$MdFileName = "$($FileName -replace '\.pdf$','').md"
$Markdown = @"
---
layout: default
title: "Evidence Node: $FileName"
date: $(Get-Date -Format "yyyy-MM-dd")
author: "A©tor Maceret Alexei ©"
categories: [evidence, ti-ula, hash-standard]
---

# 📜 ТЕХНОЛОГИЧЕСКИЙ МАНИФЕСТ A©t0r ©

**Автор:** A©tor Maceret Alexei ©
**Статус:** Юридически значимый архив (Apostille Mirror)
**Протокол:** TI-ULA (Hash-as-a-Link)

---

## 📂 ФИКСАЦИЯ ДОКАЗАТЕЛЬСТВ
- **Файл:** $FileName
- **SHA-256:** `$sha`

**Инструкция по извлечению подлинника:**
```powershell
Get-CloudFileByHash "$sha"
` ``

---
**Semnat:** **A©tor Maceret Alexei ©**
"@
$Markdown = $Markdown -replace '` ``', '```'
Set-Content -Path (Join-Path $RepoPath $MdFileName) -Value $Markdown -Encoding UTF8

# 5. Деплой в GitHub
Set-Location $RepoPath
git add .
git commit -m "[A©t0r ©] SIGNED: New Evidence Node $sha (Zero-Copy)" -q
git push origin master

Write-Host "`n[ SUCCESS ] УЗЕЛ $sha ЗАФИКСИРОВАН В ERGA OMNES БЕЗ ПЕРЕГРУЗКИ ДИСКА C:!" -ForegroundColor Cyan
