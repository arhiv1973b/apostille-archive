param(
    [Parameter(Mandatory=$true)]
    [string]$FileName,
    [string]$RepoPath = "C:\Evidence"
)

# 0. Авторизация (Локальный ключ A©t0r)
$SecureTrigger = Read-Host -Prompt "Введите секретное слово для подписи" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureTrigger)
$TriggerWord = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
if ($TriggerWord -cne "База Данных") { Write-Host "[ DENIED ]" -ForegroundColor Red; return }

Import-Module EvidenceVault -Force

# 1. Запуск конвейера TI-ULA
Write-Host "[*] Синхронизация с облачным хранилищем..." -ForegroundColor Yellow
Update-EvidenceRegistry
Sync-EvidenceVault
Resolve-CloudLinks

# 2. Извлечение хэша
$TargetFile = Join-Path $RepoPath $FileName
if (-not (Test-Path $TargetFile)) { Write-Host "[ ERROR ] Файл не найден!" -ForegroundColor Red; return }
$sha = (Get-FileHash -Path $TargetFile -Algorithm SHA256).Hash.ToUpper()

# 3. Формирование Markdown
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

# 4. Сохранение и Пуш в GitHub
Set-Content -Path (Join-Path $RepoPath $MdFileName) -Value $Markdown -Encoding UTF8
Write-Host "[ OK ] Манифест создан: $MdFileName" -ForegroundColor Green

git add .
git commit -m "[A©t0r ©] SIGNED: New Evidence Node $sha"
git push origin master # Используйте 'main', если ветка переименована

Write-Host "`n[ SUCCESS ] УЗЕЛ ЗАФИКСИРОВАН В ERGA OMNES!" -ForegroundColor Cyan
