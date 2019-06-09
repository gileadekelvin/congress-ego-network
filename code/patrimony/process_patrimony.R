#' @title Fetch the amount of money received by the candidates. Considering only the money donated by the party.
#' @description This function fetches the data from a csv provided by the TSE with the revenue of the candidates in the 2018 elections.
#' @param data_path Datapath to the file with info about revenues of the Candidates
#' @return Dataframe with info the revenue donated by the party to the candidates
#' @examples
#' revenue <- fetch_candidate_revenue(here::here("data/receitas_candidatos_2018_BRASIL.csv"))
fetch_candidate_patrimony <- function(candidates_path = here::here("data/consulta_cand_2018_BRASIL.csv"),
                                      patrimony_path = here::here("data/bem_candidato_2018_BRASIL.csv")) {
  library(tidyverse)
  
  candidates <- read_delim(delim = ";", 
                           candidates_path,
                           locale = locale(encoding = "latin1"),
                           col_types = cols(NR_CPF_CANDIDATO = "c", DS_CARGO = "c", SQ_CANDIDATO = "c"))
  
  candidates_deputies <- candidates %>% 
    filter(DS_CARGO == "DEPUTADO FEDERAL") %>% 
    select(ANO_ELEICAO, SG_UE, SQ_CANDIDATO, NR_CPF_CANDIDATO, NM_URNA_CANDIDATO, DS_OCUPACAO, DS_GRAU_INSTRUCAO)

  goods <- read_delim(delim = ";", 
                      patrimony_path,
                      locale = locale(encoding = "latin1"),
                      col_types = cols(SQ_CANDIDATO = "c"))
  
  goods_alt <- goods %>% 
    mutate(VR_BEM_CANDIDATO = as.numeric(gsub(",", ".", gsub("\\.", "", VR_BEM_CANDIDATO)))) %>% 
    select(SQ_CANDIDATO, DS_TIPO_BEM_CANDIDATO, VR_BEM_CANDIDATO)
  
  goods_summary <- goods_alt %>% 
    group_by(SQ_CANDIDATO) %>% 
    summarise(total = sum(VR_BEM_CANDIDATO))
  
  candidates_patrimony <- candidates_deputies %>% 
    left_join(goods_summary, by = "SQ_CANDIDATO") %>% 
    select(year = ANO_ELEICAO, uf = SG_UE, cpf = NR_CPF_CANDIDATO, name = NM_URNA_CANDIDATO, ocupation = DS_OCUPACAO,
           education = DS_GRAU_INSTRUCAO, patrimony = total)
  
  return(candidates_patrimony)
}