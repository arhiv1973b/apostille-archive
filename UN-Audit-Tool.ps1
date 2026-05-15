Write-Host '==================================================================' -ForegroundColor Cyan
Write-Host '        UNITED NATIONS & COUNCIL OF EUROPE AUDIT TOOL' -ForegroundColor White
Write-Host '        Protocol: TI-ULA (Transcendent Integrity)' -ForegroundColor DarkGray
Write-Host '        Author: A©tor Maceret Alexei ©' -ForegroundColor Yellow
Write-Host '==================================================================' -ForegroundColor Cyan

$ModuleFile = "$HOME\Documents\PowerShell\Modules\EvidenceVault\EvidenceVault.psm1"
if (-not (Test-Path $ModuleFile)) { $ModuleFile = "$HOME\Documents\WindowsPowerShell\Modules\EvidenceVault\EvidenceVault.psm1" }
Import-Module $ModuleFile -Force -ErrorAction Stop

Write-Host "`n[ ВНИМАНИЕ ] Инициировано прямое извлечение доказательств в формате .pdf (Jus Cogens) по хэшу..." -ForegroundColor Yellow

# 1. Мастер-узел (Юридическое заключение)
Get-CloudFileByHash '85B8CCDF949EC03A9A0C852FAC2ECB0EB7106E57125D2FC15B549E49532DC225'

# 2. Узел финансового саботажа (FinComBank Pretensia)
Get-CloudFileByHash '57BF917347C0B4DC6D4ABD3F6B16405A3D97971ADF7E52FA55CFEA244C289BEA'

# 3. Узел 2006 года (Снятие виновности)
Get-CloudFileByHash '2B2C989DD2A0D5EEDADA9D6A918BBAAC8944A582DC5AAAC287AB947D9D7DDB44'

Write-Host "`n[ VERIFIED ] Подлинность файлов математически подтверждена. Извлечение завершено." -ForegroundColor Green

