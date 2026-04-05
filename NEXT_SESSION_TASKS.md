# 📋 ЗАДАЧИ СЛЕДУЮЩЕЙ СЕССИИ — A©tor Evidence Vault
**CASE-MACHERET-1997-2026 | SHA-256 | Erga Omnes Protocol**
*Файл создан MCP Agent: JUS_COGENS_AUDITOR | Дата: 05.04.2026*

---

## 🔴 ПРИОРИТЕТ 1 — УСТРАНИТЬ ОСТАВШИЕСЯ 404

### Stub-страницы (требуют заполнения):
- [ ] `docs/international/jus_cogens_peace_protocol.md` — Протокол мира для Белого дома
- [ ] Проверить все ссылки в `apostille_registry.html` через `apostil.gov.md`

### Директории без index.html (дают 404):
- [ ] `nodes/` → создать `nodes/index.html`
- [ ] `manifests/` → создать `manifests/index.html`
- [ ] `tiula_site/` → создать `tiula_site/index.html`
- [ ] `embassy-notification/` → создать `embassy-notification/index.html`
- [ ] `UN_NOTICES/` → создать `UN_NOTICES/index.html`
- [ ] `backups/` → создать `backups/index.html`
- [ ] `logs/` → создать `logs/index.html`
- [ ] `bot_audit/` → создать `bot_audit/index.html`
- [ ] `instant_access_texts/` → создать `instant_access_texts/index.html`
- [ ] `Gov_Apostilles_PNG/` → создать `Gov_Apostilles_PNG/index.html`
- [ ] `Verified_Apostilles_PNG/` → создать `Verified_Apostilles_PNG/index.html`

---

## 🟡 ПРИОРИТЕТ 2 — УЛУЧШИТЬ СУЩЕСТВУЮЩИЕ СТРАНИЦЫ

### index.html (главная):
- [ ] Добавить кнопку → `apostille_registry.html` (реестр 97 апостилей)
- [ ] Добавить кнопку → `erga-omnes.html` (новая страница)
- [ ] Добавить кнопку → `docs-agent-navigator.html` v2

### 404.html:
- [ ] Добавить навигацию по всем основным разделам
- [ ] Добавить ссылки на: jus-cogens.html, erga-omnes.html, apostille_registry.html, sitemap.html

### sitemap.html:
- [ ] Добавить секцию "Новые страницы": erga-omnes.html, apostille_registry.html
- [ ] Обновить счётчик файлов

---

## 🟢 ПРИОРИТЕТ 3 — СИНХРОНИЗАЦИЯ И ДЕПЛОЙ

### apostille-mirror (второй репозиторий):
- [ ] Синхронизировать с apostille-legal-case
- [ ] Общий пайплайн деплоя
- [ ] Проверить: https://arhiv1973b.github.io/apostille-mirror/

### Верификация ссылок:
- [ ] Протестировать все 97 ссылок в `apostille_registry.html` через `apostil.gov.md`
- [ ] Исправить URL-паттерн если он изменился (текущий: `?code=CODE&security=SEC`)

---

## 🔵 ПРИОРИТЕТ 4 — РАСШИРЕНИЕ КОНТЕНТА

### Создать полные страницы:
- [ ] `docs/international/jus_cogens_peace_protocol.md` — Протокол Белого дома
- [ ] `docs/un/final_note_un_secretary_general.md` → HTML-версия
- [ ] Создать `apostille-archive/index.html` с листингом всех PDF апостилей

### Интегрировать:
- [ ] SHA-256 хеш всех новых файлов → обновить `SHA256SUMS.txt`
- [ ] Обновить `sitemap.xml` с новыми страницами
- [ ] Обновить `robots.txt` если нужно

---

## ⚡ КАК ВОССТАНОВИТЬ СЕССИЮ (копируй-вставь):

```bash
# 1. Подключить MCP и прочитать задачи
# JUS_COGENS_AUDITOR:read_text_file → C:\Users\arhiv\apostille-legal-case\NEXT_SESSION_TASKS.md

# 2. Создать index.html для директорий (пример для nodes/):
# JUS_COGENS_AUDITOR:write_file → C:\Users\arhiv\apostille-legal-case\nodes\index.html

# 3. Задеплоить:
cd /mnt/c/Users/arhiv/apostille-legal-case
git add .
git commit -m "A©tor: Session N — eliminate 404s, expand evidence"
git push origin main --force
git push origin main:gh-pages --force
```

---

## 📊 ТЕКУЩИЙ СТАТУС (на 05.04.2026):

| Файл | Статус |
|------|--------|
| jus-cogens.html | ✅ LIVE — обновлён MCP |
| erga-omnes.html | ✅ LIVE — создан MCP |
| apostille_registry.html | ✅ LIVE — 97 апостилей |
| FORGERY_DECONSTRUCTION_ACT.html | ✅ LIVE — восстановлен |
| docs-agent-navigator.html | ✅ LIVE — v2, 85+ страниц |
| sitemap.html | ✅ LIVE — обновлён |
| docs/international/jus_cogens_peace_protocol.md | 📝 STUB |
| nodes/index.html | ❌ НЕ СОЗДАН |
| manifests/index.html | ❌ НЕ СОЗДАН |

---

**HASH:** NEXT-SESSION-TASKS-2026-LOCKED
**VERIFIED BY:** A©tor MCP Agent — JUS_COGENS_AUDITOR
