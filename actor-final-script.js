<script>
    async function updateAthorStatus() {
        const statusEl = document.getElementById('api-status');
        const nodesEl = document.querySelector('.meta');
        try {
            const response = await fetch('http://localhost:8080/status');
            if (response.ok) {
                const data = await response.json();
                const statusText = 'API ONLINE | VERIFIED';
                if (nodesEl) {
                    nodesEl.innerHTML = `Evidence Vault Agent | Status: <span id="api-status" style="color:#00ff41; text-shadow: 0 0 10px #00ff41;">${statusText}</span> | Integrity: SHA-256 [${data.nodes} Nodes]`;
                }
                console.log("[A©TOR] Integrity Verified:", data.nodes, "nodes");
            }
        } catch (error) {
            if (statusEl) {
                statusEl.innerText = 'OFFLINE (VAULT LOCKED)';
                statusEl.style.color = '#ff0055';
                statusEl.style.textShadow = '0 0 10px #ff0055';
            }
        }
    }
    updateAthorStatus();
    setInterval(updateAthorStatus, 30000);
</script>
