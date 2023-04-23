library(tidyverse)

# Purrr -----------

# a principal função é a map()
# e temos uma "família", são várias funções map_*()
# com comportamentos similares!


## map() --------------

# Conceito do map é: dado um objeto (pode ser um vetor ou uma lista)
# queremos aplicar uma função para cada elemento desse objeto.
# isso é chamado de "mapear"
# estrutura:
# map(vetor_ou_lista, funcao)

# Lembra do exemplo que vimos na revisão, sobre loops?
for (numero in 1:5) {
  print(sqrt(numero))
}

# nesse exemplo, a função usava como vetor o 1:5, e a função era sqrt().

# Podemos reescrever esse código com map():
map(1:5, sqrt)
# o map retorna uma lista!


### Exercícios: ------------------

# 1) Dada a lista a seguir, use a função map 
# para retornar a lista com o dobro de cada elemento.
nums <- list(1, 2, 3, 4, 5)


# 2) Dada a lista a seguir,
# use a função map para retornar a lista com o número de letras 
# de cada palavra.
palavras <- list("olá", "mundo", "purrr")


# 3) Dada a lista a seguir, use a função map
# para retornar a lista com a soma de cada elemento.
numeros <- list(1:3, 4:6, 7:9)


# 4) Dada a lista a seguir,
# use a função map para retornar a lista com a média de cada elemento.
notas <- list(c(8, 7, 10), c(5, 6, 9), c(4, 5, 7))

# 5) Dada a lista a seguir, use a função map para retornar a lista 
# com cada palavra em maiúsculas.
strings <- list("purrr", "é", "incrível")


## Funções da família map -------------
# Podemos definir como queremos que seja retornado usando funções
# com classe específica
map_dbl(1:5, sqrt)
# o retorno é um vetor!

# existem outros maps que são para classes específicas:

# para textos
map_chr(c("beatriz", "daniel", "gabriel"), str_to_upper)
# para lógicos
map_lgl(c("panqueca", "lasanha", NA), is.na)

# o map_vec funciona de forma similar, sempre retorna um vetor,
# e independe da classe.
map_vec(1:5, sqrt)

### Exercícios: -----------

# 1) Dado o vetor a seguir, crie um novo vetor com o dobro de 
# cada elemento.

nums2 <- c(1, 2, 3, 4, 5)

# 2) Dado o vetor a seguir, crie um novo vetor com o número de
# letras de cada palavra.

palavras2 <- c("olá", "mundo", "purrr")


## list_c() -------
# Podemos simplificar os resultados do map
# usando a função list_c()!

map(1:5, sqrt) |> 
list_c()

# a lista vira um vetor :)
# então podemos usar map() + list_c(), ou map_vec()


## barras de progresso -------------------------------------
# podemos usar uma barra de progresso,
# usando o argumento .progress = TRUE:

map(rep(1, 10), Sys.sleep, .progress = TRUE)

# é algo muito legal, principalmente quando pode demorar um pouco para
# executar o código!


## funções ---------------------------------------------------
# podemos usar o map com funções criadas por nós!

escrever_elogio <- function(nome){
  elogios <- c("inteligente", "legal")
  elogio <- sample(elogios, 1)
  paste0(nome, " é muito ", elogio, "!")
}

# exemplo!
escrever_elogio("Bia")

map(c("Bia", "Gabi", "Dani"), escrever_elogio) 

## funções anônimas --------------------------------------------
# é uma forma de usar uma função sem ter que criar ela

# somar 1 em cada elemento
# exemplo sem funcao anonima
somar_1 <- function(x){
  x + 1
}

map(1:10, somar_1)

# exemplo COM função anonima
# sintaxe antiga
map(1:10, ~.x + 1)

# sintaxe R base desde 4.1
map(1:10, \(x) x + 1)

# é bem comum ver a sintaxe antiga ser usada por ai!!

### Exercícios: ------------------------------------

# 1) a) Crie uma função que recebe um texto contendo uma data no formato
# que usamos no Brasil (ex: "29/04/2023"), e retorna com classe data.
# Dica: a função readr::parse_date() é útil pra isso!
# veja a documentação da função, e o argumento format =

# 1) b) Aplique a funcao no vetor a seguir!

datas <- c("15/02/1993", "21/03/1998", "01/02/2000", "01/04/2012", "01/04/2012")


# 1) c) Faça o mesmo, agora usando uma função anônima.




# Funções auxiliares ---------------

## pluck() -----------

# A função pluck() é usada para extrair um elemento específico 
# de uma lista ou vetor.

# exemplo 1:
# Criando uma lista aninhada
lista <- list(a = list(x = 1, y = 2),
              b = list(z = 3))

# Extraindo o elemento 'y' da lista usando pluck
pluck(lista, "a", "y")


# exemplo 2:
# Extraindo um elemento de um modelo de regressão
modelo <- lm(mpg ~ hp + wt, data = mtcars)

str(modelo)
# Extraindo o coeficiente de intercepto do modelo
pluck(modelo, "coefficients")

# obs: apesar de ser interessante para conhecer o exemplo,
# caso precise organizar resultados de modelos eu sugiro
# usar a funcao broom::tidy()!
broom::tidy(modelo)


# exemplo 3:
# Ao criar um gráfico e salvar em um objeto,
# esse objeto será uma lista!
grafico <- dplyr::starwars |> 
  dplyr::count(sex) |> 
  ggplot() +
  aes(x = sex, y = n) +
  geom_col()

# podemos usar o pluck para acessar os elementos!
pluck(grafico, "data")
pluck(grafico, "labels")
pluck(grafico, "labels", "x")




## set_names() -------

# E se o vetor/lista não for nomeado?

# A função set_names() do pacote purrr é usada para adicionar
# ou alterar os nomes de uma lista ou vetor em R. Ela permite 
# definir ou alterar os nomes dos elementos usando um vetor de 
# caracteres como argumento.

# A sintaxe básica da função é set_names(x, nm), onde x é o objeto
# que se deseja renomear e nm é o vetor de nomes a serem usados.
# A função retorna o mesmo objeto de entrada, mas com os nomes
# atualizados.

# exemplo:
# Criando um vetor e definindo os nomes dos 
# elementos com a função set_names
vec <- c(a = 1, b = 2, c = 3)
set_names(vec, c("primeiro", "segundo", "terceiro"))

