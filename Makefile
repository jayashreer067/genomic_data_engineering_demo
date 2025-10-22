all: data/raw/hapmap1.ped results/gwas_results.qassoc results/manhattan.png

data/raw/hapmap1.ped:
	bash scripts/01_download_data.sh

results/gwas_results.qassoc:
	bash scripts/02_qc_and_assoc.sh

results/manhattan.png:
	Rscript scripts/03_visualize.R
