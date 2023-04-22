barragens_por_uf <- fs::dir_ls("dados/", glob = "*.xlsx")

dados_barragens <- purrr::map(barragens_por_uf, readxl::read_excel) |> 
  purrr::list_rbind()
