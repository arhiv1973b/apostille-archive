# Update-ActiveLinks.ps1
# Автоматизация генерации активных ссылок для реестра A©t0r ©

$RepoPath = "C:\Evidence"
$GitHubBase = "https://github.com/arhiv1973b/Evidence/blob/master"
$RegPath = Join-Path $RepoPath "hash_registry.json"
$IndexPath = Join-Path $RepoPath "MASTER_INDEX.md"

if (-not (Test-Path $RegPath)) { Write-Error "Реестр хэшей не найден!"; return }
$registry = Get-Content $RegPath -Raw | ConvertFrom-Json

# Очистка/Подготовка Индекса
$Header = @"
# MASTER_INDEX: Реестр доказательств A©t0r ©

**Автор:** A©tor Maceret Alexei ©  
**Статус:** Актуальный индекс (Apostille Mirror)  
**Протокол:** TI-ULA (Hash-as-a-Link)

| Файл | SHA-256 | Google Link | GitHub Link | WSL Path | Absolute Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
"@
Set-Content -Path $IndexPath -Value $Header -Encoding UTF8

$Manifests = Get-ChildItem -Path $RepoPath -Filter "*.md" | Where-Object { $_.Name -ne "README.md" -and $_.Name -ne "MASTER_INDEX.md" -and $_.Name -ne "GEMINI.md" }

$HandledHashes = @{}

foreach ($MdFile in $Manifests) {
    try {
        $Content = Get-Content $MdFile.FullName -Raw
        
        # Извлечение хэша из манифеста
        if ($Content -match 'Get-CloudFileByHash "([A-F0-9]{64})"') {
            $sha = $Matches[1]
        } elseif ($Content -match 'SHA-256:.*"([A-F0-9]{64})"') {
            $sha = $Matches[1]
        } elseif ($Content -match 'SHA-256:.*`([A-F0-9]{64})`') {
            $sha = $Matches[1]
        } else {
            Write-Host "[!] Хэш не найден в $($MdFile.Name)" -ForegroundColor Yellow
            continue
        }

        $HandledHashes[$sha] = $true

        $Entry = $registry.PSObject.Properties[$sha].Value
        $GoogleLink = "N/A"
        if ($Entry) {
            if ($Entry -is [string]) {
                $GoogleLink = "[Download]($Entry)"
            } elseif ($Entry.PSObject.Properties['DownloadURL']) {
                $GoogleLink = "[Download]($($Entry.DownloadURL))"
            } elseif ($registry.$sha.PSObject.Properties['Name']) {
                $RegName = $registry.$sha.Name
                $GoogleLink = "*$RegName* (Link Pending)"
            }
        }

        $FileName = $MdFile.Name
        $GitHubLink = "[$FileName]($GitHubBase/$([uri]::EscapeDataString($FileName)))"
        $WSLPath = "/mnt/c/Evidence/$FileName"
        
        # Абсолютная ссылка по хэшу
        $AbsoluteLink = "N/A"
        if ($Entry) {
            if ($Entry -is [string]) {
                $AbsoluteLink = "[$sha]($Entry)"
            } elseif ($Entry.PSObject.Properties['DownloadURL']) {
                $AbsoluteLink = "[$sha]($($Entry.DownloadURL))"
            }
        }

        # Добавление в Индекс
        $Row = "| $FileName | ``$sha`` | $GoogleLink | $GitHubLink | ``$WSLPath`` | $AbsoluteLink |"
        Add-Content -Path $IndexPath -Value $Row

        # Блок активных ссылок
        $ActiveLinksBlock = "## 🔗 АКТИВНЫЕ ССЫЛКИ`n- **Absolute Hash Link:** $AbsoluteLink`n- **Google Drive:** $GoogleLink`n- **GitHub:** $GitHubLink`n- **WSL Path:** ``$WSLPath```n- **Крипто-валидация:** ``Get-CloudFileByHash `"$sha`"``"

        if ($Content -contains "## 🔗 АКТИВНЫЕ ССЫЛКИ") {
            # Простая замена строки-заголовка и всего после нее (если это конец файла)
            # Для надежности используем split
            $Parts = $Content -split "## 🔗 АКТИВНЫЕ ССЫЛКИ"
            $NewContent = $Parts[0].Trim() + "`n`n" + $ActiveLinksBlock
        } else {
            $NewContent = $Content.Trim() + "`n`n---`n`n" + $ActiveLinksBlock
        }

        if ($NewContent.Trim() -ne $Content.Trim()) {
            Set-Content -Path $MdFile.FullName -Value $NewContent -Encoding UTF8
            Write-Host "[OK] Обновлен манифест: $($MdFile.Name)" -ForegroundColor Green
        }
    } catch {
        Write-Host "[ERROR] Ошибка в $($MdFile.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Добавление отсутствующих в манифестах хэшей из реестра
$RegistryHashes = $registry.PSObject.Properties | Where-Object { -not $HandledHashes.ContainsKey($_.Name) }
if ($RegistryHashes) {
    Write-Host "`n[*] Добавление $($RegistryHashes.Count) записей только из реестра..." -ForegroundColor Gray
    foreach ($Prop in $RegistryHashes) {
        $sha = $Prop.Name
        $Entry = $Prop.Value
        $GoogleLink = "N/A"
        $Name = "Unknown Asset"

        if ($Entry -is [string]) {
            $GoogleLink = "[Download]($Entry)"
        } else {
            if ($Entry.PSObject.Properties['DownloadURL']) { $GoogleLink = "[Download]($($Entry.DownloadURL))" }
            if ($Entry.PSObject.Properties['Name']) { $Name = $Entry.Name }
            elseif ($Entry.PSObject.Properties['FilePath']) { $Name = Split-Path $Entry.FilePath -Leaf }
        }

        $Row = "| $Name (Registry Only) | ``$sha`` | $GoogleLink | N/A | N/A | ``[$sha]($GoogleLink)`` |"
        Add-Content -Path $IndexPath -Value $Row
    }
}

Write-Host "`n[ SUCCESS ] Индекс и манифесты обновлены!" -ForegroundColor Cyan
