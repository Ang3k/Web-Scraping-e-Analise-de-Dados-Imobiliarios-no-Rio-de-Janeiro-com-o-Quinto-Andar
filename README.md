Web Scraping e Análise de Dados Imobiliários no Rio de Janeiro
Descrição
Este projeto tem como objetivo realizar a extração e análise de dados de imóveis na cidade do Rio de Janeiro, utilizando técnicas de web scraping. A partir do site do Quinto Andar, foram extraídos dados detalhados sobre diversos imóveis, incluindo informações como preço, localização, número de quartos, e características internas. Os dados são organizados em diferentes datasets que facilitam a análise e visualização de tendências do mercado imobiliário.

Tecnologias Utilizadas
Python 3.9+
Selenium: Para automação da navegação e interação com a página web.
BeautifulSoup: Para parsing do HTML e extração de informações específicas.
Requests: Para realizar requisições HTTP e obter o conteúdo das páginas.
Pandas: Para manipulação e análise dos dados extraídos.
Funcionalidades
Extração de Links de Imóveis:

Utiliza Selenium para clicar no botão "Ver Mais" e carregar mais imóveis na página principal.
BeautifulSoup é utilizado para coletar todos os links dos imóveis exibidos na página.
Coleta de Dados:

Para cada link de imóvel, o script extrai informações como preço, tipo de imóvel, número de quartos, área, localização, e tempo de publicação.
As informações são armazenadas em listas específicas para posterior organização.
Organização dos Dados:

Os dados extraídos são organizados em quatro datasets principais:
Informações Gerais: Contendo ID, tipo de imóvel, descrição, bairro, logradouro, e tempo de publicação.
Informações de Custo: Incluindo preço do imóvel, valor do condomínio, e IPTU.
Informações Internas: Detalhes como número de quartos, área, proximidade com metrô, vagas de garagem, banheiros, andares, e mobília.
Explosão de Descrição: Descrição detalhada dos itens e características de cada imóvel.
Análise e Visualização:

Os dados são preparados para análise exploratória e visualização, permitindo a criação de gráficos e modelos para análise de tendências do mercado imobiliário no Rio de Janeiro.
