Minha solução
==============

Não fiz o item #1(um caminho qualquer) pois o #2 já lista o menor caminho.

Usei neo4j com jruby, tem documentação, suite de teste com testes unitários e funcionais.

## Como usar

Para rodar o projeto é preciso ter java, neo4j, rvm e aceitar o .rvmrc desse
projeto.

Para baixar as dependências do projeto:
bundle install

Para carregar os arquivos de dados no neo4j:
rake import_data

Para rodar o servidor na porta 3000:
rails s


## Rotas

### /paths/shortest

Função:
Retorna a rota das estações com o menor caminho.

Parâmetros:
station_1 e station_2: o número das respectivas estações

### /paths/shortest

Função:
Retorna o tempo estimado da rota das estações com o menor caminho.

Parâmetros:
station_1 e station_2: o número das respectivas estações


## Exemplos de requests

Menor caminho entre a estação 11 e 290:
http://localhost:3000/paths/shortest?station_1=11&station_2=290

Tempo aproximado entra a estação 11 e 290:
http://localhost:3000/paths/approximate_time?station_1=11&station_2=290
