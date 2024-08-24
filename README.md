# Web Scraping de Dados Imobiliários

## Descrição

Este projeto realiza o scraping de dados de um site imobiliário usando Python, Selenium e BeautifulSoup. O objetivo é extrair links, detalhes de propriedades e organizar os dados em conjuntos de dados estruturados para análise posterior.

## Tecnologias Utilizadas

- **Python**
- **Selenium**: Para automação e navegação na web.
- **BeautifulSoup**: Para parsing e extração de dados HTML.
- **Pandas**: Para manipulação e organização dos dados.
- **Jupyter Notebook** (opcional): Para desenvolvimento iterativo e análise de dados.

## Funcionalidades

- **Extração de Links:** Navega pelas páginas do site imobiliário e coleta os links para as páginas das propriedades.
- **Scraping de Detalhes das Propriedades:** Visita cada link e extrai informações detalhadas como preço, localização, características do imóvel, entre outros.
- **Organização dos Dados:** Os dados extraídos são organizados em DataFrames do Pandas para análise fácil e exportação para outros formatos (por exemplo, CSV).

## Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio-imobiliario.git
   cd seu-repositorio-imobiliario

