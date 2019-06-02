#' @title Fetch data about authors of a list of propositions
#' @description Collect id and name from the authors of a list of propositions
#' @param propositions_path Data path to the list of propositions
#' @return Dataframe with the list of authors of the proposition
#' @examples
#' proposition_authors <- fetch_authors(here::here("data/propositions_2017_2018.csv"))
fetch_authors <- function(propositions_path = here::here("data/propositions_2017_2018.csv")) {
  library(tidyverse)
  library(here)
  
  propositions <- read_csv(propositions_path, col_types = "ccccccc")
  
  ids_propositions <- propositions %>% 
    distinct(id_proposition) %>% 
    tibble::rowid_to_column(var = "rowid")
  
  authors <- purrr::pmap_dfr(
    list(
      ids_propositions$id_proposition,
      ids_propositions$rowid,
      nrow(ids_propositions)
    ),
    ~ fetch_authors_by_proposition(..1, ..2, ..3)
  )
  
  return(authors)
}

#' @title Fetch data about authors of a specific proposition
#' @description Collect id and name from the authors of a proposition
#' @param id_proposition Proposition's id
#' @return Dataframe with the list of authors of the proposition
#' @examples
#' proposition_authors <- fetch_authors_by_proposition(14318)
fetch_authors_by_proposition <- function(id_proposition, current_row, total_rows) {
  library(tidyverse)
  library(here)
  library(RCurl)
  library(jsonlite)
  
  print(paste0("Downloading proposition ", id_proposition, " ", current_row, "/", total_rows))
  
  URL_AUTHORS <- "https://dadosabertos.camara.leg.br/api/v2/proposicoes/%s/autores"
  
  url <- URL_AUTHORS %>% 
    sprintf(id_proposition)
  
  data <- (getURL(url) %>% jsonlite::fromJSON())$dados
  
  data_alt <- data %>% 
    mutate(id_deputy = str_remove(uri, "https://dadosabertos.camara.leg.br/api/v2/deputados/")) %>% 
    mutate(id_proposition = id_proposition) %>% 
    select(id_proposition, id_deputy, name = nome, cod_type = codTipo, type = tipo)
  
  return(data_alt)
}


