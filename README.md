# 🎬 Análise da Base de Dados IMDb Top 1000 com SQL

Esse projeto foi desenvolvido como parte do meu aprendizado em SQL, utilizando uma base de dados com os 1000 filmes mais bem avaliados no IMDb. A ideia principal foi explorar os dados com perguntas relevantes e aplicar comandos SQL de forma prática.

---

## 📦 Base de Dados

A base contém informações como:
- Título do filme
- Diretor
- Atores principais
- Ano de lançamento
- Gênero
- Avaliação no IMDb
- Receita bruta (`Gross`)
- Número de votos

---

## ❓ Perguntas que respondi

- **🎬 Qual o diretor com mais filmes no top 1000?**
- **🎭 Quais os gêneros mais recorrentes?**
- **📆 Qual a média de nota por década?**
- **💸 Quais os filmes com maior faturamento?**
- **🌟 Qual estrela (ator/atriz) mais aparece nos filmes?**
- **📅 Quantos filmes por ano foram lançados?**
- **🗳️ Quais os filmes com maior número de votos?**
- **⭐ Gêneros com maior média de avaliação no IMDb?**

---

## 🧠 Técnicas utilizadas

- `SELECT`, `GROUP BY`, `ORDER BY`, `LIMIT`
- Funções de agregação: `COUNT`, `AVG`, `ROUND`
- Manipulação de strings com `REPLACE`
- Criação de tabelas auxiliares com `UNION ALL`
- Ordenação condicional com `CASE`
- Conversão de dados (`CAST`, `DECIMAL`)

---

## 💻 Ferramentas

- **MySQL** para execução dos comandos

---

## 🚀 Próximos passos

- Criar visualizações dos dados com ferramentas como Power BI ou Python (Matplotlib / Seaborn)
- Adicionar mais perguntas complexas
- Trabalhar com normalização da base e possíveis joins

---
## Código
#Primeiro eu alterei o nome da tabela para ficar mais fácil trabalhar
ALTER TABLE imdb_top_1000 RENAME imdb;
#Qual o diretor com mais filmes no top 1000?
SELECT director, COUNT(director) AS n_filmes FROM imdb GROUP BY director ORDER BY n_filmes DESC LIMIT 10;
#Quais os gêneros mais recorrentes?
SELECT Genre, COUNT(Genre) AS n_genre FROM imdb GROUP BY Genre ORDER BY n_genre DESC LIMIT 10;
#Qual a média de nota por década?
SELECT ROUND(Released_Year/10,0)*10 AS decade, ROUND(AVG(IMDB_rating),1) AS imdb_médio 
FROM imdb GROUP BY ROUND(Released_Year/10,0)*10 ORDER BY decade ASC;
#Quais os filmes com maior faturamento?
    UPDATE imdb SET Gross = REPLACE(Gross, ',',''); #Retirando as vírgulas como separador de milhares
SELECT Series_Title,ROUND(Gross/1000000,1) AS Gross_in_Millions FROM imdb ORDER BY
CASE 
	WHEN Gross IS NULL THEN 1
    ELSE CAST(Gross AS DECIMAL(12,1))
END DESC LIMIT 10;
#Qual estrela que mais aparece nos filmes?
#Primeiro vou criar uma nova tabela para unificar todas as 4 colunas
CREATE TABLE estrelas AS SELECT Star1 FROM imdb
UNION ALL
SELECT Star2 FROM imdb
UNION ALL
SELECT Star3 FROM imdb
UNION ALL
SELECT Star4 FROM imdb;
SELECT Star1 AS Star,COUNT(Star1) AS qtd_aparicoes FROM estrelas GROUP BY Star1 ORDER BY qtd_aparicoes DESC LIMIT 10;
#Quantos filmes por ano foram lançados?
SELECT Released_Year, COUNT(Released_Year) AS filmes_lancados FROM imdb GROUP BY Released_Year ORDER BY filmes_lancados DESC;
#Filmes com maior número de votos
SELECT Series_Title,No_of_Votes FROM imdb ORDER BY No_of_Votes DESC LIMIT 10;
#Gêneros com maior média de avaliação no IMDB
SELECT Genre,ROUND(AVG(IMDB_Rating),1) AS media FROM imdb GROUP BY Genre ORDER BY media DESC LIMIT 10;
 

## 📌 Observação

Esse projeto foi feito com muito aprendizado, erro e acerto — o objetivo principal foi treinar SQL resolvendo problemas reais com uma base divertida.  
Se quiser trocar ideia ou dar sugestões, tô por aqui! 😄

