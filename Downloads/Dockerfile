FROM alpine:latest

WORKDIR /evidence

COPY Apostilles ./Apostilles/
COPY APOSTILLE_INVESTIGATION_SUMMARY.md ./
COPY APOSTILLE_FRAUD_REPORT.md ./
COPY APOSTILLE_VERIFICATION_REPORT.md ./
COPY Downloads/FINAL_DIPLOMATIC_BRIEF.md ./
COPY Downloads/SECURITY_INCIDENT_REPORT.md ./
COPY Downloads/UN_NOTIFICATION.md ./
COPY Downloads/US_AMBASSADOR_NOTIFICATION.md ./
COPY integrity_check.py ./
COPY README.md ./
COPY metadata.jsonld ./
COPY metadata-dublin-core.xml ./
COPY "Реестр_полный_EVIDENCE.pdf" ./

RUN apk add --no-cache python3 py3-pip bash && \
    pip install --no-cache-dir pillow requests && \
    mkdir -p /integrity-hashes && \
    find . -type f \( -name "*.pdf" -o -name "*.md" \) -exec sha256sum {} \; > /integrity-hashes/registry.json && \
    find . -type f \( -name "*.pdf" -o -name "*.md" \) -printf "%p|%s|%T@\n" > /integrity-hashes/sbom.csv && \
    echo "SBOM Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)" > /integrity-hashes/manifest.json

LABEL description="Legal evidence for Maceret case - CASE-MACHERET-1997-2026"
LABEL case_id="CASE-MACHERET-1997-2026"
LABEL commit="9f021cd"
LABEL tag="STABLE-REVOLUTION-2026"
LABEL disability_group="I"
LABEL legal_status="Art. 3 ECHR vulnerability"
LABEL sbom="spdx-json"

CMD ["sh", "-c", "echo '========================================' && echo 'CASE-MACHERET-1997-2026 - Evidence Vault' && echo 'Tag: STABLE-REVOLUTION-2026' && echo 'Commit: 9f021cd' && echo '========================================' && echo '' && echo '=== RUNNING INTEGRITY CHECK ===' && python3 integrity_check.py && echo '' && echo '=== DISPLAYING DIPLOMATIC BRIEF ===' && cat FINAL_DIPLOMATIC_BRIEF.md"]
