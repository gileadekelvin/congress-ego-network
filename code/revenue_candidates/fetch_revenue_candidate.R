#' @title Fetch the amount of money received by the candidates. Considering only the money donated by the party.
#' @description This function fetches the data from a csv provided by the TSE with the revenue of the candidates in the 2018 elections.
#' @param data_path Datapath to the file with info about revenues of the Candidates
#' @return Dataframe with info the revenue donated by the party to the candidates
#' @examples
#' revenue <- fetch_candidate_revenue(here::here("data/receitas_candidatos_2018_BRASIL.csv"))
fetch_candidate_revenue <- function(data_path = here::here("data/receitas_candidatos_2018_BRASIL.csv")) {
  library(tidyverse)
  
  entries <- read_delim(delim = ";", 
                        data_path,
                        locale = locale(encoding = "latin1"),
                        col_types = cols(NR_CPF_CANDIDATO = "c", DS_CARGO = "c", DS_ORIGEM_RECEITA = "c",
                                         VR_RECEITA = "c"))
  
  entries_summary <- entries %>%
    filter(DS_ORIGEM_RECEITA == "Recursos de partido político",
           DS_CARGO == "Deputado Federal") %>% 
    mutate(VR_RECEITA = as.numeric(gsub(",", ".", gsub("\\.", "", VR_RECEITA)))) %>% 
    group_by(NR_CPF_CANDIDATO) %>% 
    summarise(received_from_party = sum(VR_RECEITA),
              name = first(NM_CANDIDATO),
              party = first(SG_PARTIDO),
              post = first(DS_CARGO),
              uf = first(SG_UE)
              ) %>% 
    select(cpf_candidate = NR_CPF_CANDIDATO, name, post, party, uf, received_from_party)
  
  return(expenses_summary)
}
