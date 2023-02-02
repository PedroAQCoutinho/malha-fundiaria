
DROP TABLE auxiliares.step14_chave_agrupamento;
CREATE TABLE auxiliares.step14_chave_agrupamento
(
id_agrup INT NULL,
nm_agrup TEXT NULL
);



INSERT INTO auxiliares.step14_chave_agrupamento (nm_agrup, id_agrup ) VALUES
('publica_afetada' , 1),
('glebas_publicas' , 4),
('vazio' , 9),
('imovel_rural_privado' , 5),
('coletiva_privada' , 2),
('publica_afetada__imovel_rural_privado' , 8),
('publica afetada_coletiva_privada' , 3),
('coletiva_privada_imovel_privado' , 7),
('imovel_privado_coletivo_publica_destinada' , 6);



DROP TABLE IF EXISTS auxiliares.step14_chave_categorias_limpas;
CREATE TABLE auxiliares.step14_chave_categorias_limpas
(
id_cat_fund INT NULL,
nm_cat_fund TEXT NULL
);



INSERT INTO auxiliares.step14_chave_categorias_limpas (nm_cat_fund, id_cat_fund ) VALUES
('zonas_sobreposicao' , 1),
('vazio' , 10),
('assentamento' ,11),
('militar' , 2),
('ucp', 3),
('ucpiucu', 4),
('ucus' , 5),
('qui' , 6),
('ti' , 7),
('gleba' , 8),
('imovel' , 9);
