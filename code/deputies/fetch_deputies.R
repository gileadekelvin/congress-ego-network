#' @title Collect info about members of the Chamber of Deputies (Brazil)
#' @description Collect info like name, party, gender, function to the members of the Chamber of Deputies (Brazil)
#' @param id Deputies's id
#' @param rowid current row id of interation
#' @param total total of deputies
#' @return Dataframe informações de id e nome civil.
#' @examples
#' deputy <- fetch_deputy(id)
fetch_deputy <- function(id, rowid = 1, total = 1) {
  library(tidyverse)
  library(RCurl)
  library(jsonlite)
  
  print(paste0("Downloading info to the deputy with id ", id, " - ", rowid, "/", total))
  url <- paste0("https://dadosabertos.camara.leg.br/api/v2/deputados/", id)
  
  deputy <- tryCatch({
    data <-  RCurl::getURL(url) %>% 
      jsonlite::fromJSON() %>% 
      unlist() %>% t() %>% 
      as.data.frame() 
    
    if (!"dados.ultimoStatus.situacao" %in% names(data)) {
      data$dados.ultimoStatus.situacao = NA
    }
    
    if (!"dados.escolaridade" %in% names(data)) {
      data$dados.escolaridade = NA
    }
    
    data <- data %>% 
      mutate(house = "camara") %>% 
      select(id = dados.id, 
             house,
             cpf = dados.cpf,
             civilian_name = dados.nomeCivil,
             electoral_name = dados.ultimoStatus.nomeEleitoral,
             state = dados.ultimoStatus.siglaUf,
             party_name = dados.ultimoStatus.siglaPartido,
             condition = dados.ultimoStatus.situacao,
             gender = dados.sexo,
             schooling = dados.escolaridade,
             email = dados.ultimoStatus.gabinete.email)
    
  }, error = function(e) {
    message(e)
    data <- tribble(~ id, ~ house, ~ civilian_name, ~ electoral_name, ~ state, ~ party_number,
                    ~ party_name, ~ condition, ~ gender, ~ schooling, ~ email)
    return(data)
  })
  
  return(deputy)
}

#' @title Get data to the deputies of a specific legislature in the Chamber of Deputies
#' @description Get data to the deputies of a specific legislature in the Chamber of Deputies
#' @return Dataframe with info about the deputies
#' @examples
#' deputies <- fetch_deputies_by_legislature(56)
fetch_deputies_by_legislature <- function(legislature = 56) {
  library(tidyverse)
  library(RCurl)
  library(jsonlite)
  
  url <- paste0("https://dadosabertos.camara.leg.br/api/v2/deputados?idLegislatura=", legislature)
  
  deputies_ids <- (RCurl::getURL(url) %>%
          jsonlite::fromJSON())$dados %>%
    distinct(id) %>% 
    tibble::rowid_to_column(var = "rowid")

  personnal_info <- purrr::pmap_dfr(
    list(
      deputies_ids$id,
      deputies_ids$rowid,
      nrow(deputies_ids)
    ),
    ~ fetch_deputy(..1, ..2, ..3)
  )
  
  return(personnal_info)
}