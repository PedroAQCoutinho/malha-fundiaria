import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
formatter = logging.Formatter('%(levelname)s:%(name)s:%(message)s')
file_handler = logging.FileHandler('appfunctions.log')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)



# Etapas para compor as 7 camadas fundiárias

# 1 - Subir todas as camadas brutas em schema temporário no banco de dados
# 2 - Carregar todas as camadas , reparar geometria inválidas
# 3 - Limpar geometrias inválidas de cada camada de entrada



