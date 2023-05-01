library(readxl)
library(janitor)
library(writexl)
library(fs)
library(tidyverse)

barragens <- read_excel("dados/Relatorio_20233322.xlsx", skip = 3) |> clean_names()

dir_create("dados_output")

write_xlsx(barragens, path = "dados_output/barragens_completo.xlsx")

tabela <- barragens |> 
  group_by(uf) |> 
  nest()


map2(
  .x = tabela$uf,
  .y = tabela$data,
  ~ write_xlsx(.y, path = paste0("dados_output/barragens_", .x, ".xlsx")),
  .progress = TRUE
)



  