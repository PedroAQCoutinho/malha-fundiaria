DROP  TABLE IF EXISTS temporario.test;
CREATE TABLE temporario.test AS
SELECT  FROM layer_fundiario.categorias_fundiarias_agrupadas cfa LIMIT 1;