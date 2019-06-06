#' @title Get data from propositions that have occurred between an initial date and a final date considering a specific API page
#' @description Collect info link id of proposition, name, resume using a period of time
#' The Chamber of Deputies API returns all propositions that have been processed in a period of time in an orderly and paginated manner. 
#' This function retrieves the data from these propositions considering all pages returned by API.
#' @param initial_date Initial date as the lower limit for the proceedings of the proposition in the Chamber 
#' Format: YYYY-MM-DD
#' @param final_date Initial date as the upper limit for the procedure of the motion in the Chamber
#' Format: YYYY-MM-DD
#' @return Dataframe with info about propositions
#' page (API), id_proposition, initials_type, cod_type, number, year, summary
#' @examples
#' propositions <- fetch_tramited_propositions("2017-01-01", "2018-12-31")
fetch_tramited_propositions <- function(initial_date = "2017-01-01", final_date = "2018-12-31") {
  library(tidyverse)
  library(RCurl)
  library(jsonlite)
  
  url_api <- "https://dadosabertos.camara.leg.br/api/v2/proposicoes?dataInicio=%s&dataFim=%s&ordem=ASC&ordenarPor=id&pagina=1&itens=100"
  
  url <- url_api %>% 
    sprintf(initial_date, final_date)
  
  links <- (getURL(url) %>% jsonlite::fromJSON())$links
  
  last_page <- links %>% 
    filter(rel == "last") %>% 
    pull(href) %>% 
    str_match("pagina=(.*?)&") %>% 
    tibble::as_tibble(.name_repair = c("universal")) %>% 
    pull(`...2`)
    
  propositions <- tibble(page = 1:as.numeric(last_page)) %>%
    mutate(data = map(
      page,
      fetch_propositions_by_page,
      initial_date,
      final_date,
      as.numeric(last_page)
    )) %>% 
    unnest(data)
}

#' @title Get data from propositions that have occurred between an initial date and a final date
#' @description Collect info link id of proposition, name, resume using a period of time
#' The Chamber of Deputies API returns all propositions that have been processed in a period of time in an orderly and paginated manner. This function retrieves the data from these propositions to an API-specific page.
#' @param page page of API return to get info
#' @param initial_date Initial date as the lower limit for the proceedings of the proposition in the Chamber 
#' Format: YYYY-MM-DD
#' @param final_date Initial date as the upper limit for the procedure of the motion in the Chamber
#' Format: YYYY-MM-DD
#' @param last_page Number of pages that API returns with info about propositions (considering the period of time passed as parameter)
#' @return Dataframe with info about propositions
#' id_proposition, initials_type, cod_type, number, year, summary
#' @examples
#' propositions <- fetch_propositions_by_page(1, "2017-01-01", "2018-12-31", 632)
fetch_propositions_by_page <- function(page = 1, initial_date = "2017-01-01", final_date = "2018-12-31", last_page = 632) {
  library(tidyverse)
  library(RCurl)
  library(jsonlite)
  
  print(paste0("Downloading page ", page, "/", last_page))
  url_api <- "https://dadosabertos.camara.leg.br/api/v2/proposicoes?dataInicio=%s&dataFim=%s&ordem=ASC&ordenarPor=id&pagina=%s&itens=100"
  
  url <- url_api %>% 
    sprintf(initial_date, final_date, page)
  
  data <- (getURL(url) %>% jsonlite::fromJSON())$dados %>% 
    select(-uri)
  
  return(data)
}

