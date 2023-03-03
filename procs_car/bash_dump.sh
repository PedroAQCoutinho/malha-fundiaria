pg_dump -t car.proc2_array_agg -d malha_fundiaria -U postgres > proc2_array_agg.sql

gcloud compute scp pedro_alves_coutinho_usp_br@gpp-malha:/home/pedro_alves_coutinho_usp_br/proc2_array_agg hd1/pedro/GPP/ltmodel/outputs/car/proc2_array_agg. 
hd1/pedro/GPP/ltmodel/outputs/car/proc2_array_agg.sql   hd1/pedro/GPP/ltmodel/outputs/car/proc2_array_agg.tif