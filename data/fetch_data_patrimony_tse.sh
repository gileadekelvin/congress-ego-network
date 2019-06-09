#!/bin/bash

echo "Downloading data"
for ano in 2018; do 
	echo "Fetching year $ano"
	curl -o consulta_cand_${ano}.zip agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_${ano}.zip
  unzip -j consulta_cand_${ano}.zip consulta_cand_${ano}_BRASIL.csv -d .
  curl -o bem_candidato_${ano}.zip agencia.tse.jus.br/estatistica/sead/odsele/bem_candidato/bem_candidato_${ano}.zip
  unzip -j bem_candidato_${ano}.zip bem_candidato_${ano}_BRASIL.csv -d .
done
