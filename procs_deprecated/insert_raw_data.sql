--Modelo shp2pgsql [options] <shapefile> [[schema.]table]
--Assentamentos federais
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/Assentamento Federal.shp" dados_brutos.Assentamento_federal | psql -U postgres -d malha_fundiaria
--Assentamento Reconhecimento
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/Assentamento Reconhecimento.shp" dados_brutos.Assentamento_reconhecimento | psql -U postgres -d malha_fundiaria
--SERVIÇO FLORESTAL
declare -a arr=("AC" "AL" "AM" "AP" "BA" "CE" "DF" "ES" "GO" "MA" "MG" "MS" "MT" "PA" "PB" "PE" "PI" "PR" "RJ" "RN" "RO" "RR" "RS" "SC" "SE" "SP" "TO")
for i in "${arr[@]}" 
do 
(shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/CNFP_2020_$i.shp" dados_brutos.CNFP_2020_$i | psql -U postgres -d malha_fundiaria)
done
--TERRAS INDÍGENAS
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/GEOFT_TERRA_INDIGENA.shp" dados_brutos.GEOFT_TERRA_INDIGENA | psql -U postgres -d malha_fundiaria
--UNIDADES DE CONSERVAÇÃO
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/GEOFT_UNIDADE_CONSERVACAO.shp" dados_brutos.GEOFT_UNIDADE_CONSERVACAO | psql -U postgres -d malha_fundiaria
--Imóvel certificado SNCI Privado
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/Imóvel certificado SNCI Privado.shp" dados_brutos.Imovel_certificado_SNCI_Privado | psql -U postgres -d malha_fundiaria
--Imóvel certificado SNCI Público
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/Imóvel certificado SNCI Público.shp" dados_brutos.Imovel_certificado_SNCI_Publico | psql -U postgres -d malha_fundiaria
--Areas de Quilombolas
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/╡reas de Quilombolas.shp" dados_brutos.areas_de_Quilombolas | psql -U postgres -d malha_fundiaria
--Sigef Privado
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/Sigef Privado.shp" dados_brutos.Sigef_Privado | psql -U postgres -d malha_fundiaria
--Sigef Público
shp2pgsql -c -I "/home/pedro/hd1/pedro/GPP/escolhas/inputs/dados_INCRA_2022/Sigef Público.shp" dados_brutos.Sigef_Publico | psql -U postgres -d malha_fundiaria





