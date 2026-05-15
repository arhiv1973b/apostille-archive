# [ A©t0r © ] Universal Deployment Script
# Node Hash: 4E97A58E1EEF4E420BE7DA055B70BDC51EC3E1F8E7E3AD4457D1D771DC6F831A

Write-Host "=== Инициализация восстановления узла A©t0r ===" -ForegroundColor Cyan
$Target = Read-Host "Введите путь для развертывания (например, C:\Evidence_Restored)"
if (-not (Test-Path $Target)) { New-Item -Path $Target -ItemType Directory }

Expand-Archive -Path ".\4E97A58E1EEF4E420BE7DA055B70BDC51EC3E1F8E7E3AD4457D1D771DC6F831A.zip" -DestinationPath $Target -Force

Set-Location $Target
Write-Host "Восстановление Docker-контейнеров..." -ForegroundColor Yellow
wsl docker build -t aytor-bastion ./Cloud_Bastion/
wsl docker build -t aytor-watchdog ./Docker_Monitor/

Write-Host "[ SUCCESS ] Структура TI-ULA полностью развернута из хэш-узла." -ForegroundColor Green
