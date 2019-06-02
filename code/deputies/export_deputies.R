library(tidyverse)
library(here)
source(here::here("code/deputies/fetch_deputies.R"))

if(!require(optparse)){
  install.packages("optparse")
  suppressWarnings(suppressMessages(library(optparse)))
}

args = commandArgs(trailingOnly=TRUE)

message("Access the README")
message("Use --help to get more info\n")

option_list = list(
  make_option(c("-o", "--out"), type="character", default=here("data/deputies.csv"), 
              help="Path to the output csv [default= %default]", metavar="character"),
  make_option(c("-l", "--legislature"), type="character", default=56, 
              help="Number of the legislature to get the data from deputies [default= %default]", 
              metavar="character")
) 

opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

saida <- opt$out
leg <- opt$legislature

message("Starting fetching...")
message("Downloading data...")
deputies <- fetch_deputies_by_legislature(leg)

message(paste0("Writing csv: ", saida))
write_csv(deputies, saida)

message("Done!")