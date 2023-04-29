# Lembre-se que a funcão tem a seguinte estrutura
# nome_da_funcao <- function(argumento_1, argumento_2) {
#   
#   # Código que a função irá executar,
#   # usando o argumento_1 e argumento_2
#   
# }

# EXERCÍCIOS - FUNÇÕES BÁSICO
# 1) Crie uma função que receba um número e retorne o quadrado deste número.


# 2) Crie uma função que recebe dois números e retorne a soma destes números.


# 3) Crie uma função que receba 2 números e devolva a raiz quadrada da soma
# desses números.


# 4) Crie uma função que receba dois valores (numéricos) e devolva o maior deles.



# EXERCÍCIOS - FUNÇÃO - Adaptando um código que funciona :)

# Transforme o código abaixo em uma função! Objetivo: função que retorna qual 
# é o lucro do filme. A função deve ser chamada 'calcular_lucro_filme_pixar()' e ter o
# argumento 'filme_pixar'.


# Código original ----------------------------------------------

library(tidyverse)
library(dados)

pixar_bilheteria |>
  filter(filme == "Carros") |> 
  mutate(lucro = bilheteria_mundial - orcamento) |> 
  pull(lucro) |> 
  scales::dollar()

# Escreva abaixo sua função -------------------------------------------




# Verificação -------------------------------------------------------------

# Use a função para ver se ela funciona!

# O filme mais recente da pixar com dados de orçamento e receita é o filme Soul.
# Ele foi lançado durante a pandemia.
# Esse filme deu prejuízo ou lucro?

calcular_lucro_filme_pixar("Soul")

# Calcule o lucro do seu filme favorito da pixar! 

calcular_lucro_filme_pixar()



# VAMOS AO PURRR  -----------------------
rstudioapi::documentOpen("scripts/03-purrr.R")
