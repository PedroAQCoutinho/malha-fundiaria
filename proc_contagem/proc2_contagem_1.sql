-- contagem
\echo contagem de propriedades
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS queries.count_grid;
CREATE TABLE queries.count_grid
(
  id serial4 NOT null,
  contagem int4 NULL
);




CREATE INDEX count_grid_id_idx ON queries.count_grid USING btree (id);
CREATE INDEX count_grid_contagem_idx ON queries.count_grid USING btree (contagem);
