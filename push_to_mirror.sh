#!/bin/bash

# Массив ТОЧНЫХ имен папок из твоего Google Drive
FOLDERS=(
    "UN"
    "Папака  расследований  нарушенного Римского  статута и Венской Конвенции"
    "Папка не законно закрытых дел"
    "Дело по Марковой из КПС"
    "A©tor-Shared"
    "Для Судебного Исполнителя"
)

echo "--- [A©t0r Mirroring] Запуск протокола ---"

for folder in "${FOLDERS[@]}"; do
    echo "Проверка узла: $folder..."
    if rclone lsd "gdrive:$folder" >/dev/null 2>&1; then
        echo "Синхронизация узла: $folder..."
        rclone copy "gdrive:$folder" "./$folder" --progress --drive-shared-with-me --drive-acknowledge-abuse
    else
        echo "⚠️ Папка '$folder' не найдена в Google Drive, пропуск..."
    fi
done

echo "--- [Integrity Check] Генерация манифеста ---"
# Создаем цифровую печать (хеши) для всех файлов
find . -type f ! -name "integrity_manifest.sha256" ! -path "./.git/*" ! -name "push_to_mirror.sh" -exec sha256sum {} + > integrity_manifest.sha256

echo "--- [GitHub Push] Отправка в зеркало ---"
git add .
git commit -m "Jus Cogens Update: $(date +'%Y-%m-%d %H:%M:%S') [A©t0r Verified]"
git push -u origin main
echo "--- [Status] Зеркало CASE-MACHERET обновлено ---"
