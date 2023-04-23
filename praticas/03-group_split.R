library(tidyverse)

# download desses dados:
# https://dadosabertos.ibama.gov.br/dataset/dof-autorizacoes-de-exploracao-florestal

# Endereço padrao:

baixar_dados_autorizacao_exploracao_florestal <- function(uf, ano) {
  url_buscar <-
    paste0("http://dadosabertos.ibama.gov.br/dados/DOF/",
           uf,
           "/autorizacao/",
           ano,
           ".csv")
  
  caminho_baixar <- paste0("data/autorizacao_exploracao_florestal_",
                           uf, "_",
                           ano, ".csv")
  
  resposta <- httr::GET(url_buscar, 
                        config = httr::config(ssl_verifypeer = FALSE),
                        httr::write_disk(caminho_baixar, overwrite = FALSE))
  
  resposta$status_code
}

# Pensar primeiro: o que queremos mapear?
# anos
anos <- 2007:2023

# estados
uf <- unique(geobr::grid_state_correspondence_table$abbrev_state)

# combinações: tudo com tudo, com expand_grid():
combinacoes <- tidyr::expand_grid(anos, uf) |> 
  tibble::rowid_to_column()

# group_split vai criar listas pra cada grupo
listas_grupos <- combinacoes |> 
  dplyr::group_split(rowid)

# usar purrr map
purrr::map(
  .x = listas_grupos,
  .f = ~ baixar_dados_autorizacao_exploracao_florestal(.x$uf, .x$anos), 
  .progress = TRUE
)



