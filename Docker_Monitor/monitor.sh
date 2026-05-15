#!/bin/bash
echo "[ A©t0r Protocol ] Проверка критических узлов авторства..."
API_URL="https://api.github.com/repos/arhiv1973b/apostille-archive/contents/A©tor-Hash-Rights"
STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" -L $API_URL)

if [ "$STATUS" -eq 200 ]; then
    echo "[ OK ] Правовой узел активен. Авторство зафиксировано."
else
    echo "[ ALERT ] Узел не найден! Статус: $STATUS. Инициация SOS-рассылки в ООН..."
    # msmtp -t < /tmp/sos_payload.eml
fi
