#!/usr/bin/env bash
set -euo pipefail
PLINK=${PLINK:-plink}

RAW=data/raw
PROC=data/processed
RES=results
mkdir -p $PROC $RES

# 1. Convert text PED/MAP to binary
$PLINK --file $RAW/hapmap1 --make-bed --out $PROC/base

# 2. Basic QC
$PLINK --bfile $PROC/base \
       --geno 0.05 --mind 0.05 --maf 0.05 \
       --make-bed --out $PROC/clean

# 3. Simple association
$PLINK --bfile $PROC/clean --pheno data/raw/qt.phe --assoc --allow-no-sex --out $RES/gwas_results

echo "[OK] Association test complete."
