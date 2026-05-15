param(
    [string]$SourcePath = "H:\Загрузки"
)

Write-Host "`n=== [ A©t0r © ] ПОТОКОВАЯ ZERO-COPY ИНДЕКСАЦИЯ ===`n" -ForegroundColor Cyan

# 1. Единовременная авторизация
$SecureTrigger = Read-Host -Prompt "Введите секретное слово ОДИН РАЗ" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureTrigger)
$TriggerWord = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
if ($TriggerWord -cne "База Данных") { Write-Host "[ DENIED ]" -ForegroundColor Red; return }

# 2. Поиск файлов (Без копирования!)
$Allowed = @(".pdf", ".jpg", ".jpeg", ".png", ".json", ".jsonl", ".csv", ".txt")
$Files = Get-ChildItem -Path $SourcePath -File | Where-Object { $Allowed -contains $_.Extension.ToLower() }

$total = $Files.Count
$count = 0

Write-Host "[*] Найдено объектов для потоковой отправки: $total" -ForegroundColor Yellow

# 3. Скоростной цикл
foreach ($File in $Files) {
    $count++
    Write-Host "`n[$count/$total] Обработка: $($File.Name)" -ForegroundColor DarkGray
    
    # Прямой вызов нового Publish-EvidenceNode (он сам всё сделает, не копируя файл)
    & "C:\Evidence\Publish-EvidenceNode.ps1" -TargetFile $File.FullName
}

Write-Host "`n[ TOTAL SUCCESS ] Очередь обработана в режиме Zero-Copy!" -ForegroundColor Green
