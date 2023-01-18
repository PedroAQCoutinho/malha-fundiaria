import geopandas as gpd


pais = gpd.read_file('../../../../../dados_GPP/geo_adm/pais/BR_Pais_2021.shp')
estados = gpd.read_file('../../../../../dados_GPP/geo_adm/uf/BR_UF_2021.shp')
estados = estados.loc[estados['SIGLA'] == 'TO']
estados = estados.to_crs(pais.crs)

print(f'Pais {pais.crs}')

print(f'Estados {estados.crs}')


uni = pais.overlay(estados, how = 'union')
uni.to_file('../../outputs/temporarios/test.shp')