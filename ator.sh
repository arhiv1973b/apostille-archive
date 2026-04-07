#!/bin/bash
find_port() {
    for port in 8080 8081 8082 8083 8888; do
        if curl -s "http://localhost:${port}/status" >/dev/null 2>&1; then
            echo $port
            return
        fi
    done
    echo 8080
}

PORT=$(find_port)
API="http://localhost:$PORT"

if [ "$1" == "--direct" ]; then
    echo "💬 A©tor direct mode"
    echo "🔗 Port: $PORT"
    while true; do
        echo -n "ATOR> "
        read cmd
        if [ "$cmd" == "exit" ]; then break; fi
        
        result=$(curl -s -X POST "$API/execute" \
            -H "Content-Type: application/json" \
            -d "{\"command\": \"$cmd\"}")
        
        echo "$result" | jq -r '.stdout' 2>/dev/null || echo "$result"
        echo
    done
elif [ "$1" == "--status" ]; then
    curl -s "$API/status" | jq .
else
    result=$(curl -s -X POST "$API/execute" \
        -H "Content-Type: application/json" \
        -d "{\"command\": \"$1\"}")
    echo "$result" | jq -r '.stdout' 2>/dev/null || echo "$result"
fi
