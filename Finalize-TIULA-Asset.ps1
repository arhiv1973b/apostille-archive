# Finalize-TIULA-Asset.ps1
# Алгоритм завершения загрузки: Верификация хэша и добавление расширения

param(
    [string]$TargetDir = "."
)

$RegPath = "C:\Evidence\hash_registry.json"
if (-not (Test-Path $RegPath)) { Write-Error "Реестр хэшей не найден!"; return }
$registry = Get-Content $RegPath -Raw | ConvertFrom-Json

Write-Host "=== [ A©t0r © ] TI-ULA ASSET FINALIZER ===" -ForegroundColor Cyan

$Files = Get-ChildItem -Path $TargetDir -File | Where-Object { $_.BaseName -match '^[A-F0-9]{64}$' -and $_.Extension -eq "" }

if ($Files.Count -eq 0) {
    Write-Host "Файлы без расширения, соответствующие формату SHA-256, не найдены." -ForegroundColor Gray
    return
}

foreach ($File in $Files) {
    $ExpectedHash = $File.BaseName
    Write-Host "[*] Проверка: $ExpectedHash" -NoNewline
    
    # Расчет хэша
    $ActualHash = (Get-FileHash $File.FullName -Algorithm SHA256).Hash
    
    if ($ActualHash -eq $ExpectedHash) {
        Write-Host " [ VALID ]" -ForegroundColor Green
        
        # Поиск расширения в реестре
        $Ext = ".bin" # По умолчанию
        $Entry = $registry.PSObject.Properties[$ActualHash].Value
        if ($Entry) {
            if ($Entry -is [string]) {
                # Пытаемся угадать по URL или оставить .bin
                if ($Entry -match '\.pdf') { $Ext = ".pdf" }
                elseif ($Entry -match '\.json') { $Ext = ".json" }
            } elseif ($Entry.PSObject.Properties['FilePath']) {
                $Ext = [System.IO.Path]::GetExtension($Entry.FilePath)
            } elseif ($Entry.PSObject.Properties['Name'] -match '\.pdf') {
                $Ext = ".pdf"
            }
        }

        $NewName = $ActualHash + $Ext
        $NewPath = Join-Path $File.DirectoryName $NewName
        
        Rename-Item -Path $File.FullName -NewName $NewName -Force
        Write-Host " [+] Финализирован: $NewName" -ForegroundColor Cyan
    } else {
        Write-Host " [ INVALID ]" -ForegroundColor Red
        Write-Host "  (!) Хэш содержимого ($ActualHash) не совпадает с именем ($ExpectedHash)" -ForegroundColor Yellow
    }
}

Write-Host "`n[ SUCCESS ] Цикл финализации завершен." -ForegroundColor Green
