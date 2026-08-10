# 📊 Analytics & Predição na Educação Básica: Infraestrutura, Inclusão Digital e Risco de Evasão em MG (2019–2025)

[![Python](https://img.shields.io/badge/Python-3.10%2B-blue?logo=python)](https://www.python.org/)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-red?logo=microsoftsqlserver)](https://www.microsoft.com/sql-server)
[![Scikit-Learn](https://img.shields.io/badge/Scikit--Learn-Machine%20Learning-orange?logo=scikit-learn)](https://scikit-learn.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🎯 Objetivo Geral do Projeto

Este projeto consolida uma plataforma analítica e preditiva desenvolvida sobre os **Microdados do Censo Escolar da Educação Básica (INEP)** no estado de **Minas Gerais**, cobrindo a série histórica de **2019 a 2025**.

O objetivo principal é transformar dados públicos em **ferramentas de tomada de decisão para a gestão pública educacional**, mapeando a evolução dos indicadores de infraestrutura e conectividade, identificando assimetrias regionais nos 853 municípios mineiros e construindo um **Sistema de Alerta Precoce de Evasão Escolar** direcionado à alocação eficiente de recursos e intervenções prioritárias.

---

## 📝 Resumo do Ecossistema Analítico (Notebooks)

O projeto é estruturado em três módulos integrados que acompanham todo o ciclo dos dados — da análise histórica até a inteligência preditiva:

* **`01_analise_exploratoria_educacao_mg.ipynb` (Diagnóstico Histórico e Estrutural):** 
  Analisa a evolução da infraestrutura física e digital das escolas públicas mineiras entre **2019 e 2025**. Mapeia quais recursos (como laboratórios, bibliotecas e saneamento) mais se conectam com o porte escolar e identifica gargalos de oferta nas diferentes etapas de ensino.

* **`02_geoprocessamento_mapa_mg.ipynb` (Mapeamento Geográfico e Territorial):** 
  Transforma os indicadores municipais em **mapas interativos (HTML)**. Permite identificar espacialmente as regiões de "apagão tecnológico" em Minas Gerais, orientando o direcionamento regional de investimentos em banda larga e laboratórios de informática.
  
  > 🌐 **Acesse os Mapas Interativos em Tempo Real (GitHub Pages):**
  > * 🗺️ [Mapa Interativo de Conectividade Escolar (MG)](https://julianomata.github.io/Projeto-Educacao-Analytics/Imagens/mapa_interativo_conectividade_mg.html)
  > * 🖥️ [Mapa Interativo de Laboratórios de Informática (MG)](https://julianomata.github.io/Projeto-Educacao-Analytics/Imagens/mapa_interativo_laboratorios_mg.html)

* **`03_modelo_preditivo_alerta_evasao.ipynb` (Machine Learning e Alerta Precoce):** 
  Aplica Inteligência Artificial (`RandomForestClassifier`) sobre as **11.950 escolas públicas ativas de MG** para calcular o **Score de Vulnerabilidade** ($0$ a $100$) e classificar as unidades em faixas de risco (🔴 **Crítico**, 🟡 **Médio**, 🟢 **Baixo**). Gera a **Matriz Nominativa de Intervenção Prioritária** para apoiar ações preventivas contra a evasão escolar.

---

## 🌐 Fonte dos Dados

Os microdados utilizados são de domínio público, disponibilizados pelo **Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira (INEP)**.

* 🔗 **Portal de Download dos Microdados (INEP):** [https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar)

> *Nota: Os dados brutos não são versionados no repositório por questões de volumetria. Eles devem ser baixados diretamente do portal do INEP e armazenados no diretório `Dados_Educacao/` conforme instruído abaixo.*

---

## 🏗️ Arquitetura do Repositório

```text
📁 Projeto_Educacao_Analytics/
├── 📁 Dados_Educacao/           # Diretório de dados (Dados brutos ignorados pelo Git)
│   └── 📁 outputs/              # Datasets preditivos e agregados gerados pelos pipelines
│       ├── matriz_alerta_evasao_mg.csv
│       ├── tb_mg_dados_georeferenciados.csv
│       ├── tb_mg_infra_serie_historica.csv
│       ├── tb_mg_infra_serie_historica.parquet
│       └── tb_top50_municipios_criticos.csv
├── 📁 Imagens/                  # Gráficos em Alta Resolução e Mapas HTML Interativos
│   ├── fig02_matriz_correlacao_mg.png
│   ├── fig03_evolucao_temporal_conectividade_mg.png
│   ├── fig03_feature_importance_evasao.png
│   ├── fig04_perfil_oferta_etapas_mg.png
│   ├── mapa_interativo_conectividade_mg.html
│   └── mapa_interativo_laboratorios_mg.html
├── 📁 Notebooks/                # Pipelines Analíticos e Preditivos em Python (Jupyter)
│   ├── 01_analise_exploratoria_educacao_mg.ipynb
│   ├── 02_geoprocessamento_mapa_mg.ipynb
│   └── 03_modelo_preditivo_alerta_evasao.ipynb
├── 📁 Scripts_SQL/              # Modelagem DW, Staging e Views Analíticas (T-SQL)
│   ├── 01_criacao_banco_de_dados.sql
│   └── ...
├── .gitignore                   # Regras de exclusão do Git
├── LICENSE                      # Licença MIT
├── README.md                    # Documentação do Projeto
└── requirements.txt             # Dependências e Bibliotecas do Python
```
## 💻 Módulos do Pipeline Analítico

| Notebook | Foco / Módulo | Principais Entregas / Artefatos |
| :--- | :--- | :--- |
| **`01_analise_exploratoria`** | Análise Temporal & Estatística | Mapeamento da evolução temporal (2019–2025), matriz de correlação de Spearman e perfil de oferta por etapa de ensino. |
| **`02_geoprocessamento`** | Análise Espacial Interativa | Mapas interativos Folium HTML (`mapa_interativo_conectividade_mg.html` e `laboratorios_mg.html`) por município. |
| **`03_modelo_preditivo`** | Machine Learning & Alerta Precoce | Treinamento do `RandomForestClassifier`, extração da *Feature Importance* e geração da `matriz_alerta_evasao_mg.csv`. |
---

## 🚀 Como Executar o Projeto Localmente

### 1. Clonar o Repositório e Configurar o Ambiente Virtual

```powershell
# Clonar o repositório
git clone [https://github.com/JulianoMata/Projeto_Educacao_Analytics.git](https://github.com/JulianoMata/Projeto_Educacao_Analytics.git)
cd Projeto_Educacao_Analytics

# Criar o ambiente virtual
python -m venv .venv

# Ativar o ambiente virtual (Windows PowerShell)
.\.venv\Scripts\Activate.ps1

# Instalar as dependências do projeto
pip install -r requirements.txt
```

### 2. Conectar com o SQL Server

1. Certifique-se de que a instância local do **Microsoft SQL Server** esteja em execução.
2. Garanta que o banco de dados `Educacao_Analytics` e as views da camada analítica estejam devidamente criados e executados executando os arquivos da pasta `Scripts_SQL/`.

---

## 👤 Autor

**Juliano França da Mata**  
* Graduando em Bacharelado em Ciência de Dados e Inteligência Artificial (UniDomBosco)  
* Tecnólogo em Gestão de Tecnologia da Informação (UniCesumar)  
* Agente Administrativo e Técnico em Informática  

---

## 📜 Licença

Este projeto está licenciado sob os termos da licença **MIT**. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.