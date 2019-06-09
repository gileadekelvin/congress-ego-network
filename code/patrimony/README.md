# Instructions

To retrieve the patrimony of the candidates to the post of Federal deputy

1. Download the accounts accountability data of the candidates in the 2018.
    - You can use the fetch_data_patrimony_tse.sh script in the / data directory. Just execute: `/fetch_data_patrimony_tse.sh`.
    This will download and extract the data from the patrimony in the 2018 elections.
2. Use the function provided by the fetch_candidate_patrimony.R file to generate the patrimony of the candidate.
You can call a function like that (in a Rscript file that you can create) `fetch_candidate_patrimony(here::here("data/consulta_cand_2018_BRASIL.csv"), here::here("data/bem_candidato_2018_BRASIL.csv"))`

You can also use the csv with the candidates to the post of Federal Deputy that is available in the data directory. (patrimony_candidates_deputy_2018.csv*)