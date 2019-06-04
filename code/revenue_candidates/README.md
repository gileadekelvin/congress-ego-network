# Instructions

To retrieve the revenue data of the candidates received through party donations you must follow the instructions below.

1. Download the accounts accountability data of the candidates in the 2018.
    - You can use the fetch_data_tse.sh script in the / data directory. Just execute: `/ fetch_data_tse.sh`.
    This wiil download and extract the data from the revenue in the 2018 elections.
    - Another way is to manually download the data from the TSE (website)[agencia.tse.jus.br/estatistica/sead/odsele/prestacao_contas/prestacao_de_contas_eleitorais_candidatos_2018.zip].
    Then extract the file *receitas_candidatos_2018_BRASIL.csv* to the /data directory. DO NOT extract the whole zip, is more than 27 GB! 
2. Use the function provided by the fetch_revenue_candidate.R file to generate the amount of manoey received by the candidate from the party.
You can call a function like that (in a Rscript file that you can create) `fetch_candidate_revenue(here::here("data/receitas_candidatos_2018_BRASIL.csv"))`

You can also use the csv with the candidates to the post of Federal Deputy that is available in the data directory. (*revenue_candidates_deputy_2018.csv*)