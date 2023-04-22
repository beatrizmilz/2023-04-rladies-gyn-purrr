library(tidyverse)
library(xml2)

nome_colunas <- c("nome", "desc", "valor")

"https://www.beleaf.com.br/cardapio-marmitas-veganas" |>
  read_html() |>
  xml_find_all("//div[contains(@class, 'product-item-details')]") |>
  map(xml_children) |> 
  map(xml_text) |> 
  map(str_squish) |> 
  map(set_names, nm = nome_colunas) |> 
  map(enframe) |> 
  map(pivot_wider) |> 
  list_rbind() 
