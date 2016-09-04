#!/bin/bash -e

#python scrape_votacao_novaseleicoes.py


for run in {1..10}
do
	echo "msg3"
	#atualiza a cada 10 min
	Rscript diretasja.R

	git add . 
	git commit -m "atualizacao"
	git push https://github.com/joaomeirelles/raspa_senado_ecidadania
	sleep 1m
done
