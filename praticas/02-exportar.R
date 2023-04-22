dados <- "dados/Relatorio_20233322.xlsx"

barragens <- readxl::read_excel(dados, skip = 2) |> 
  janitor::clean_names()

tabela <- barragens |> 
  dplyr::group_by(uf) |>
  tidyr::nest()


purrr::map2(
  .x = tabela$uf,
  .y = tabela$data,
  ~ writexl::write_xlsx(
    .y,
    path = paste0("dados_output/barragens_", .x, ".xlsx")
  )
)
