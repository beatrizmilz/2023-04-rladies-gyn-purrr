# Conteúdos de R básico importantes para entender `purrr` ---

## Tipos de variáveis ---------------------------------------
# existem vários tipos de variáveis
# cada um tem suas propriedades
# a função class() permite descobrir a classe
# alguns exemplos: 

# textos: sempre tem aspas
class("Beatriz")

# números / numeric / double
class(30)
class(30.1)

# lógico/boleano: verdadeiro/falso
class(TRUE)
class(FALSE)

# podemos converter objetos usando funções que começam com as.*()
# essa conversão é chamada de coerção

class("1993-02-15")

class(as.Date("1993-02-15"))

as.numeric(TRUE)

as.numeric(FALSE)

as.character(30)


# Logico > Numérico > Texto



## Tipos de objetos -----------------------------------------

# Três tipos de objetos importantes nesse momento
# (não são os únicos!)


### Vetores ----------
# conjunto de elementos
# pode ser criado usando a função c():

c(1, 2, 3)

vetor_exemplo <- c(1, 2, 3)

# 1 dimensão

str(vetor_exemplo)

# sempre 1 classe de variável

class(vetor_exemplo)

# isso é importante! 
# e se criar um vetor com elementos de classes diferentes?
x <- c(TRUE, 10, 20, 30, "40")

class(x) # acontece a coerção! ele muda os elementos para a classe mais geral.

# logico > numerico > texto


# também é possível criar um vetor com uma sequência usando :

1:10

10:1


### Data frames --------------------

irmaos <- data.frame(
  nome = c("Beatriz", "Andressa", "Vitor", "Gabriel", "Daniel"),
  idade = c(30, 25, 22, 11, 11)
)

# classe
class(irmaos)

# tem 2 dimensões: linhas e colunas!

# Cada coluna funciona como um vetor, e pode ser acessado usando $:
irmaos$nome
irmaos$idade

# Cada coluna pode ter uma classe diferente,
# mas dentro de cada coluna só pode ter elementos de uma mesma classe

class(irmaos$nome)
class(irmaos$idade)


# Um objeto similar é a tibble, e utilizaremos como SINÔNIMOS:

dplyr::starwars

class(dplyr::starwars)

### Listas ---
# Pode ter vários elementos!
# É criado com a função list()
# Podemos nomear os elementos da lista
# Cada elemento pode ser de um diferente tipo de objeto

lista_irmaos <- list(
 estado = "SP",
 municipio_nascimento = list(diadema = c("Beatriz", "Andressa", "Vitor"),
                             sao_paulo = c("Gabriel", "Daniel")),
 dados = irmaos
)


# Podemos acessar elementos da lista usando o $

lista_irmaos$dados # dataframe dentro da lista

lista_irmaos$estado # vetor

lista_irmaos$municipio_nascimento

# Listas podem guardar.. listas!

lista_irmaos$municipio_nascimento$diadema

lista_irmaos$municipio_nascimento$sao_paulo


# Podemos acessar também os elementos da lista pela posição e o subsetting: []

lista_irmaos[[1]]
lista_irmaos[[2]]
lista_irmaos[[3]]

lista_irmaos[[2]][[1]]
lista_irmaos[[2]][[2]]


## Exercícios: 

# https://forms.gle/BCedfboc66fVY2NZA


## For Loops  -------
# Usados para repetições/iterações

# Exemplo: queremos apresentar no console (fazer um print) a raíz quadrada 
# de cada número entre 1 até 5
# Sem for loop : repetir manualmente (maior chance de erros)
print(sqrt(1))
print(sqrt(2))
print(sqrt(3))
print(sqrt(4))
print(sqrt(5))

# Estrutura:
# for (variable in vector) {
#   o_que_deve_ser_executado
# }

for (variable in vector) {
  
}
# vetor: 1:5
# variable: x, y, n , m, i

# Com for loop:

for (numero in 1:5) {
  print(sqrt(numero))
  Sys.sleep(1)
}

## Funções -------

# podemos entender funções que guardam um código em R
# quando executamos a função, o código é executado
# podemos informar argumentos, para serem usados no código

# a ideia é que cada função faz uma pequena tarefa

# Exemplo de funções que já conhecemos

# criar um vetor
c(1:10)

# criar uma lista
list(x = 1:10, y = 21:30)

# criar um data frame
data.frame(x = 1:10, y = 21:30)

# consultar a classe
class(1)
class(mtcars)

# consultar a data
Sys.Date()

# Esperar
Sys.sleep(1)

# transformar um texto em tipo data
as.Date("2023-04-29")

# calcular a raíz quadrada
sqrt(9)

print("Oi meu nome é Beatriz")

# funcoes de outros pacotes!
dplyr::glimpse(irmaos)

# podemos CRIAR nossas próprias funções
# criamos experiência na medida que praticamos
# dava para fazer um meetup só de funções haha, então vamos resumir
# estrutura:

# name <- function(variables) {
#   
# }

# nome_da_funcao <- function(nome_do_argumento1, nome_do_argumento2) {
#   corpo da função: o que será executado
# }
# Por padrão, a função retornará sempre a última
# linha de código que existir dentro dela.

# Exemplo 1
contador_de_dias <- function(x){
  as.Date(x) - Sys.Date()
}

# nesse caso, a função se chama contador de dias.
# ela recebe 1 argumento

# Usar a função criada
contador_de_dias("2023-10-14")

contador_de_dias("2024-01-01")

# Exemplo 2
converter_datas_br <- function(x){
  readr::parse_date(x, format = "%d/%m/%Y")
}

# Experimentando a função
converter_datas_br("14/10/2023")

# usando as duas funções
converter_datas_br("14/10/2023") |> contador_de_dias()

# Funções podem ter vários argumentos! 
# argumentos podem ter valores padrão.
contar_diferenca_de_datas <- function(data_final, data_inicial = Sys.Date()){
  as.Date(data_final) - as.Date(data_inicial)
}

# se não colocamos o nome dos argumentos, são usados na ordem.
contar_diferenca_de_datas("2023-10-14", "2023-04-21")

contar_diferenca_de_datas("2023-10-14")


# podemos nomear os argumentos!
contar_diferenca_de_datas(data_inicial = "2023-04-21", 
                          data_final = "2023-10-14")


# Uma estratégia para criar funções é escrever um trecho de código que funciona
# e adaptar para uma função...





# EXERCÍCIOS - FUNÇÕES BÁSICO: 02-exercicios-funcoes.R -----------------------
rstudioapi::documentOpen("scripts/02-exercicios-funcoes.R")


