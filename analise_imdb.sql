#1-Primeiro eu alterei o nome da tabela para ficar mais fácil trabalhar
  ALTER TABLE imdb_top_1000 RENAME imdb;
#2-Qual o diretor com mais filmes no top 1000?
  SELECT director, COUNT(director) AS n_filmes FROM imdb GROUP BY director ORDER BY n_filmes DESC LIMIT 10;
#3-Quais os gêneros mais recorrentes?
  SELECT Genre, COUNT(Genre) AS n_genre FROM imdb GROUP BY Genre ORDER BY n_genre DESC LIMIT 10;
#4-Qual a média de nota por década?
  SELECT ROUND(Released_Year/10,0)*10 AS decade, ROUND(AVG(IMDB_rating),1) AS imdb_médio 
  FROM imdb GROUP BY ROUND(Released_Year/10,0)*10 ORDER BY decade ASC;
#5-Quais os filmes com maior faturamento?
  UPDATE imdb SET Gross = REPLACE(Gross, ',',''); #Retirando vírgulas como separador de milhares
  SELECT Series_Title,ROUND(Gross/1000000,1) AS Gross_in_Millions FROM imdb ORDER BY
  CASE 
  	WHEN Gross IS NULL THEN 1
    ELSE CAST(Gross AS DECIMAL(12,1))
  END DESC LIMIT 10;
#6-Qual estrela que mais aparece nos filmes?
#Primeiro vou criar uma nova tabela para unificar todas as 4 colunas
  CREATE TABLE estrelas AS SELECT Star1 FROM imdb
  UNION ALL
  SELECT Star2 FROM imdb
  UNION ALL
  SELECT Star3 FROM imdb
  UNION ALL
  SELECT Star4 FROM imdb;
  SELECT Star1 AS Star,COUNT(Star1) AS qtd_aparicoes FROM estrelas GROUP BY Star1 ORDER BY qtd_aparicoes DESC LIMIT 10;
#7-Quantos filmes por ano foram lançados?
  SELECT Released_Year, COUNT(Released_Year) AS filmes_lancados FROM imdb GROUP BY Released_Year ORDER BY filmes_lancados DESC;
#8-Filmes com maior número de votos
SELECT Series_Title,No_of_Votes FROM imdb ORDER BY No_of_Votes DESC LIMIT 10;
#9-Gêneros com maior média de avaliação no IMDB
SELECT Genre,ROUND(AVG(IMDB_Rating),1) AS media FROM imdb GROUP BY Genre ORDER BY media DESC LIMIT 10;
 
