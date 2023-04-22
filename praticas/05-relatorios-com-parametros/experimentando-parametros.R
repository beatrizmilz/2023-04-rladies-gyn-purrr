library(quarto)


arquivo_qmd <-
  "praticas/05-relatorios-com-parametros/relatorio-exemplo.qmd"

# Conseguimos usar o knit usando essa funcao
quarto_render(input = arquivo_qmd)

# Podemos passar parâmetros no argumento param
quarto_render(input = arquivo_qmd, execute_params = list(estado = "MG"))


# podemos passar o nome do arquivo no argumento output_file
quarto_render(
  input = arquivo_qmd,
  execute_params = list(estado = "MG"),
  output_file = "relatorio_barragens_MG.html"
)


# podemos transformar isso em uma funcao
gerar_relatorio_uf <- function(uf) {
  quarto_render(
    input = arquivo_qmd,
    execute_params = list(estado = uf),
    output_file = glue::glue("relatorio_barragens_{uf}_{Sys.Date()}.html")
  )
}

# uf <- "X"
# paste0("relatorio_barragens_", uf, ".html")

# Exemplo de uso da funcao
gerar_relatorio_uf("MG")


# -----------

# map(.x = CONJUNTO_DE_VALORES_QUE_QUEREMOS_QUE_A_FUNCAO_SEJA_APLICADA,
# .f = FUNCAO_QUE_QUEREMOS_APLICAR, .progress = TRUE)

# vetor para repetir
estados_com_barragens <- unique(barragens$uf)


map(estados_com_barragens, gerar_relatorio_uf, .progress = TRUE)


# gerar PDF

relatorios_html <- fs::dir_ls("praticas/05-relatorios-com-parametros/",
                              glob = "*.html")

map(relatorios_html, pagedown::chrome_print, .progress = TRUE)

beepr::beep()
