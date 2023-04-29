barragens_por_uf <- fs::dir_ls("dados/", glob = "*barragens_*.xlsx")

dados_barragens <- purrr::map(barragens_por_uf, readxl::read_xlsx) |> 
  purrr::list_rbind()
  
