#!/usr/bin/env bash
set -euo pipefail
mkdir -p data/raw

cd data/raw
# Download PLINK example data (tiny HapMap subset)
curl -sSL https://zzz.bwh.harvard.edu/plink/hapmap1.zip -o hapmap1.zip
unzip -o hapmap1.zip >/dev/null
echo "[OK] Downloaded HapMap example data."
