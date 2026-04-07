#!/bin/bash
echo "🚀 Запуск A©tor Direct Access System..."

# Запуск API сервера в фоне
python3 ator-api.py &
API_PID=$!

# Сохранение PID
echo $API_PID > ator-api.pid

# Ожидание запуска
sleep 2

echo "✅ A©tor API запущен (PID: $API_PID)"
echo "🔗 API Endpoint: http://localhost:8080"
echo "💬 Прямой доступ: ./ator.sh --direct"
echo "📊 Статус: ./ator.sh --status"
echo "🛑 Остановка: kill $API_PID"
