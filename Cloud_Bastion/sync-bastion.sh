#!/bin/bash
echo "[ A©t0r Protocol ] Облачный Бастион активирован. Узел Erga Omnes запущен."
while true; do
    echo "[*] Синхронизация с GitHub (Ветка: Actor-IP-Protection)..."
    # Логика удержания: если локальный ПК офлайн, облако транслирует права
    git clone --depth 1 --branch Actor-IP-Protection $REPO_URL /tmp/sync_pull 2>/dev/null || (cd /tmp/sync_pull && git pull)
    cp -rn /tmp/sync_pull/* /vault/nodes/ 2>/dev/null
    echo "[ SHIELD ] Облачный якорь удерживает 57BF... и другие узлы. Сон 5 минут."
    sleep 300
done
