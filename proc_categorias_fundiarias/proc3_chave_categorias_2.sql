DROP TABLE malhav2.proc3_chave_categorias;
CREATE TABLE malhav2.proc3_chave_categorias AS 
SELECT DISTINCT original_layer 
FROM (SELECT 
anyarray_sort(anyarray_uniq(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(array_remove(array_remove(array_remove(original_layer, 'FF'),'CAR'), 'MD'), 'ASSENREC', 'ASSEN'), 
'ASSENFED', 'ASSEN'),
'GLEBAEST', 'GLEBA'),
'GLEBAFED', 'GLEBA'), 
'SIGEFPUB', 'GLEBA'), 
'SNCIPUB', 'GLEBA'), 
'TERRALEG', 'IMOVEL'), 
'SIGEFPRIV', 'IMOVEL'), 
'SNCIPRIV', 'IMOVEL'))) original_layer
FROM malhav2.proc2_malhav2 pm WHERE original_layer != '{NULL}' ) foo