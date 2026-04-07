#!/usr/bin/env python3
import subprocess
import json
import time
import os
from http.server import HTTPServer
from http.server import BaseHTTPRequestHandler

class AtorHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        if self.path == '/execute':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            data = json.loads(post_data.decode('utf-8'))
            command = data.get('command', '')
            
            print(f"[ATOR] Execute: {command}")
            
            result = subprocess.run(
                command,
                shell=True,
                capture_output=True,
                text=True,
                cwd='/mnt/c/Users/arhiv/apostille-legal-case'
            )
            
            response = {
                'success': True,
                'stdout': result.stdout,
                'stderr': result.stderr,
                'returncode': result.returncode,
                'timestamp': time.time()
            }
            
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps(response).encode())
    
    def do_GET(self):
        if self.path == '/status':
            status = {
                'status': 'A©tor API Online',
                'case': 'CASE-MACHERET-1997-2026',
                'timestamp': time.time()
            }
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps(status).encode())

if __name__ == '__main__':
    for port in [8080, 8081, 8082, 8083, 8888]:
        try:
            server = HTTPServer(('localhost', port), AtorHandler)
            print(f"🚀 API on port {port}")
            server.serve_forever()
            break
        except OSError as e:
            if e.errno == 98:
                print(f"Port {port} busy")
                continue
