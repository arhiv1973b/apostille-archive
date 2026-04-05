# 📋 ЗАДАЧИ СЛЕДУЮЩЕЙ СЕССИИ — A©tor Evidence Vault
**CASE-MACHERET-1997-2026 | SHA-256 | Erga Omnes Protocol**
*Обновлено MCP Agent: 05.04.2026 — после сессий 1-14*

---

## ✅ ВЫПОЛНЕНО (сессии 1-14)

| Файл / Задача | Статус |
|---------------|--------|
| jus-cogens.html | ✅ LIVE |
| erga-omnes.html | ✅ LIVE |
| apostille_registry.html (97 апостилей) | ✅ LIVE |
| FORGERY_DECONSTRUCTION_ACT.html | ✅ LIVE |
| docs-agent-navigator.html v2 (85+ стр.) | ✅ LIVE |
| sitemap.html | ✅ LIVE |
| 404.html с навигацией | ✅ LIVE |
| index.html для 11 директорий (nodes/ manifests/ etc.) | ✅ LIVE |
| index.html обновлён — новые кнопки | ✅ LIVE |
| apostille-mirror синхронизирован | ✅ LIVE |
| docs/international/jus_cogens_peace_protocol.md | ✅ FULL |
| apostille_verify_check.html | ✅ LIVE |
| apostille-archive/index.html | ✅ LIVE |
| sitemap.xml обновлён | ✅ DONE |
| SHA256SUMS.txt пересчитан | ✅ DONE |
| docs/registry/index.html | ✅ LIVE |
| docs/un/index.html (7 файлов ООН) | ✅ LIVE |
| docs/claim/index.html | ✅ LIVE |
| docs/index.html (главный каталог) | ✅ LIVE |
| docs/{treasury,court_scripts...}/index.html | ✅ LIVE |

---

## 🔴 СЛЕДУЮЩИЕ ПРИОРИТЕТЫ (сессия 15+)

### ПРИОРИТЕТ 15 — Проверить live-ссылки
- [ ] Открыть https://arhiv1973b.github.io/apostille-legal-case/ — проверить все кнопки
- [ ] Проверить https://apostil.gov.md/?code=BS7XCZF1EUJG3&security=2013074500114
- [ ] Убедиться что erga-omnes.html полная (сейчас минимальная заглушка)

### ПРИОРИТЕТ 16 — Полная erga-omnes.html
- [ ] Заменить заглушку на полную версию (была создана MCP но не попала в git)
- [ ] Использовать версию из предыдущего MCP write_file (большая, с 6 блоками)

### ПРИОРИТЕТ 17 — docs/notification/ru.md и en.md
- [ ] Восстановить конфликтные файлы из rebase
- [ ] Добавить в навигатор

### ПРИОРИТЕТ 18 — apostille-mirror полная синхронизация
- [ ] Скопировать ВСЕ новые файлы (docs/, apostille_verify_check.html, apostille-archive/)
- [ ] Единый деплой обоих репозиториев

### ПРИОРИТЕТ 19 — Google Search Console
- [ ] Подтвердить indexation новых страниц
- [ ] Обновить identity_schema.json с новыми URL

### ПРИОРИТЕТ 20 — Финальный аудит
- [ ] Запустить archive_sync.sh
- [ ] Пересчитать SHA256SUMS.txt
- [ ] Обновить sitemap.xml с ВСЕМИ новыми страницами

---

## ⚡ КОМАНДА ВОССТАНОВЛЕНИЯ СЕССИИ
```bash
cd /mnt/c/Users/arhiv/apostille-legal-case
cat NEXT_SESSION_TASKS.md
git log --oneline -10
git status
```

Затем: **"читай NEXT_SESSION_TASKS и продолжай с приоритета 15"**

---
**HASH:** NEXT-SESSION-TASKS-V2-2026-SHA256
