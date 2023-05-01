library(quarto)

# rmarkdown::render()

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
gerar_relatorio_uf_v1 <- function(uf) {
  quarto_render(
    input = arquivo_qmd,
    execute_params = list(estado = uf),
    output_file = glue::glue("relatorio_barragens_{uf}_{Sys.Date()}.html")
  )
}

gerar_relatorio_uf_v1("AM")

# Ainda não está com o comportamento esperado!

gerar_relatorio_uf <- function(uf_funcao){
  
  arquivo_html <- glue::glue("praticas/05-relatorios-com-parametros/relatorio_barragens_{uf_funcao}.html")
  
  quarto_render(input = arquivo_qmd,
                execute_params = list(estado = uf_funcao),
                quiet = TRUE)
  
  
  # mover para a pasta desejada
  fs::file_move(
    path = "praticas/05-relatorios-com-parametros/relatorio-exemplo.html",
    new_path = arquivo_html
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

barragens <- readxl::read_xlsx("praticas/05-relatorios-com-parametros/sigbm.xlsx", skip = 3)

estados_com_barragens <- unique(barragens$UF)

library(tidyverse)
map(estados_com_barragens, gerar_relatorio_uf, .progress = TRUE)


# gerar PDF

relatorios_html <- fs::dir_ls("praticas/05-relatorios-com-parametros/",
                              glob = "*.html")

map(relatorios_html, pagedown::chrome_print, .progress = TRUE)

beepr::beep()
