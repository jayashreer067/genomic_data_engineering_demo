#!/usr/bin/env Rscript
suppressPackageStartupMessages({
  library(data.table)
  library(qqman)
})

# pick the first existing result file
cands <- c("results/gwas_results.qassoc",
           "results/gwas_results.assoc",
           "results/gwas_results.assoc.logistic")
f <- cands[file.exists(cands)][1]
if (is.na(f)) stop("No GWAS results found in results/.")

dt <- fread(f)
# normalize expected columns
stopifnot(all(c("CHR","SNP","BP") %in% names(dt)))
# choose p-value column
pcol <- if ("P" %in% names(dt)) "P" else if ("P_LINREG" %in% names(dt)) "P_LINREG" else "P" # fallback
dt <- dt[is.finite(get(pcol))]
dt[, CHR := as.numeric(CHR)]
dt[, BP  := as.numeric(BP)]

png("results/manhattan.png", 1600, 900, res=150)
manhattan(dt, chr="CHR", bp="BP", p=pcol, snp="SNP",
          main=sprintf("GWAS Manhattan Plot (%s)", basename(f)),
          suggestiveline=-log10(1e-5), genomewideline=-log10(5e-8))
dev.off()

png("results/qqplot.png", 1200, 900, res=150)
qq(dt[[pcol]], main=sprintf("GWAS QQ Plot (%s)", basename(f)))
dev.off()

cat("[OK] Saved plots to results/.\n")
