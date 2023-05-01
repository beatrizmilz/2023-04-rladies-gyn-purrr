library(readxl)
library(fs)
library(purrr)

barragens_am <- read_excel("dados/barragens_AM.xlsx")

dir_ls("dados/")

dir_ls("dados/", glob = "*.xlsx")

xlsx_barrages_por_uf <- dir_ls("dados/", glob = "*barragens_*.xlsx")

# dir_tree()

# rbind = row bind = colar linhas -> empilha!

barragens <- map(xlsx_barrages_por_uf, read_excel, .progress = TRUE) |>
  list_rbind(names_to = "uf")



