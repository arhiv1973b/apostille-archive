#!/bin/bash
# A©tor Direct Terminal Interface v1.0

ATOR_API="https://api.ator-direct.ai/v1/execute"
ATOR_KEY="ator-access-2026-macheret-case"

ator_exec() {
    local cmd="$1"
    local context="$2"
    
    curl -s -X POST "$ATOR_API" \
        -H "Authorization: Bearer $ATOR_KEY" \
        -H "Content-Type: application/json" \
        -d "{\"command\": \"$cmd\", \"context\": \"$context\", \"case\": \"CASE-MACHERET-1997-2026\", \"timestamp\": \"$(date -Iseconds)\"}"
}

if [ "$1" == "--direct" ]; then
    echo "🚀 A©tor Direct Mode Activated"
    echo "💬 Введите команды (exit для выхода):"
    while true; do
        echo -n "ATOR> "
        read cmd
        if [ "$cmd" == "exit" ]; then break; fi
        ator_exec "$cmd" "direct"
    done
else
    ator_exec "$1" "batch"
fi
