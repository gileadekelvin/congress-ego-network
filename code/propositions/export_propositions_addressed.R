library(tidyverse)
library(here)
source(here::here("code/co_authors/fetch_propositions_by_date.R"))

if(!require(optparse)){
  install.packages("optparse")
  suppressWarnings(suppressMessages(library(optparse)))
}

args = commandArgs(trailingOnly=TRUE)

message("Access the README")
message("Use --help to get more info\n")

option_list = list(
  make_option(c("-o", "--out"), type="character", default=here("data/propositions_addressed.csv"), 
              help="Path to the output csv [default= %default]", metavar="character"),
  make_option(c("-i", "--initial"), type="character", default="2017-01-01", 
              help="Initial date as the lower limit for the proceedings of the proposition in the Chamber. Format: YYYY-MM-DD", 
              metavar="character"),
  make_option(c("-f", "--final"), type="character", default="2018-12-31", 
              help="Initial date as the upper limit for the procedure of the motion in the Chamber. Format: YYYY-MM-DD", 
              metavar="character")
) 

opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

saida <- opt$out
initial_date <- opt$initial
final_date <- opt$final

message("Starting fetching...")
message("Downloading data...")
message("It may take several minutes if the time period is large")
propositions <- fetch_tramited_propositions(initial_date, final_date)

message(paste0("Writing csv: ", saida))
write_csv(propositions, saida)

message("Done!")