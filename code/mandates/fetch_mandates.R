#' @title Get data from deputies and their mandates
#' @description Collect data with the list of deputies that participated in the Chamber of Deputies in a period of time. 
#' If a deputy is in a lesgilature, he will be returned by the api considering the initial and final date passed as parameters
#' @param initial_date Initial date as the lower limit for the period of mandate
#' Format: YYYY-MM-DD
#' @param final_date Initial date as the upper limit for the period of mandate
#' Format: YYYY-MM-DD
#' @return Dataframe with info about deputies
#' page (API), id_deputy, idLegislature, name, party, uf
#' @examples
#' deputies <- fetch_mandates_deputies("1900-01-01", "2099-01-01")
fetch_mandates_deputies <- function(initial_date = "1900-01-01", final_date = "2099-01-01") {
  library(tidyverse)
  library(RCurl)
  library(jsonlite)
  
  url_api <- "https://dadosabertos.camara.leg.br/api/v2/deputados?&dataInicio=%s&dataFim=%s&ordem=ASC&ordenarPor=nome&pagina=1&itens=100"
  
  url <- url_api %>% 
    sprintf(initial_date, final_date)
  
  links <- (getURL(url) %>% jsonlite::fromJSON())$links
  
  last_page <- links %>% 
    filter(rel == "last") %>% 
    pull(href) %>% 
    str_match("pagina=(.*?)&") %>% 
    tibble::as_tibble(.name_repair = c("universal")) %>% 
    pull(`...2`)
  
  deputies <- tibble(page = 1:as.numeric(last_page)) %>%
    mutate(data = map(
      page,
      fetch_deputies_by_page,
      initial_date,
      final_date,
      as.numeric(last_page)
    )) %>% 
    unnest(data) %>% 
    select(page, id_deputy = id, idLegislature = idLegislatura, name = nome, party = siglaPartido, uf = siglaUf)
  
  return(deputies)
}

#' @title Get data from deputies and their respective mandates
#' @description Collect list of deputies per legsilature.
#' @param page page of API return to get info
#' @param initial_date Initial date as the lower limit for the period of mandate
#' Format: YYYY-MM-DD
#' @param final_date Initial date as the upper limit for the period of mandate
#' Format: YYYY-MM-DD
#' @param last_page Number of pages that API returns
#' @return Dataframe with info about deputies and the legislature that they participated
#' @examples
#' mandates <- fetch_deputies_by_page(1, "2017-01-01", "2018-12-31", 135)
fetch_deputies_by_page <- function(page = 1, initial_date = "1900-01-01", final_date = "2099-01-01", last_page = 135) {
  library(tidyverse)
  library(RCurl)
  library(jsonlite)
  
  print(paste0("Downloading page ", page, "/", last_page))
  url_api <- "https://dadosabertos.camara.leg.br/api/v2/deputados?&dataInicio=%s&dataFim=%s&ordem=ASC&ordenarPor=nome&pagina=%s&itens=100"
  
  url <- url_api %>% 
    sprintf(initial_date, final_date, page)
  
  data <- (getURL(url) %>% jsonlite::fromJSON())$dados %>% 
    select(-uriPartido, -uri, -urlFoto)
  
  return(data)
}

