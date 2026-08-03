# 📊 Analytics & Predição na Educação Básica: Infraestrutura, Inclusão Digital e Risco de Evasão em MG (2019–2025)

[![Python](https://img.shields.io/badge/Python-3.10%2B-blue?logo=python)](https://www.python.org/)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-red?logo=microsoftsqlserver)](https://www.microsoft.com/sql-server)
[![Scikit-Learn](https://img.shields.io/badge/Scikit--Learn-Machine%20Learning-orange?logo=scikit-learn)](https://scikit-learn.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 📝 Sobre o Projeto

Este projeto consiste em uma plataforma analítica e preditiva desenvolvida sobre os **Microdados do Censo Escolar da Educação Básica (INEP)** no estado de **Minas Gerais**, cobrindo a série histórica de **2019 a 2025**.

O ecossistema une modelagem em **Data Warehouse (SQL Server)**, **Análise Exploratória**, **Geoprocessamento** e **Machine Learning (Random Forest)** para:
1. Diagnosticar a evolução dos indicadores de infraestrutura física, saneamento e conectividade nas escolas públicas mineiras.
2. Mapear espacialmente a distribuição de laboratórios de informática e redes de banda larga nos municípios de MG.
3. Classificar o **Risco de Evasão Escolar** por meio de um **Score de Vulnerabilidade Reequilibrado**, gerando uma **Matriz Nominativa de Alerta Precoce** para suporte à tomada de decisão no setor público.

---

## 🌐 Fonte dos Dados

Os microdados originais utilizados neste projeto são de domínio público e disponibilizados pelo **Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira (INEP)**.

* 🔗 **Portal de Download dos Microdados do Censo Escolar (INEP):** [https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar)

> *Nota: Devido ao grande volume de dados brutos (arquivos `.zip` e diretórios descompactados), os dados brutos não são versionados no Git. Eles devem ser baixados diretamente do link do INEP e armazenados na pasta `Dados_Educacao/` conforme instruções de execução.*

---

## 🏗️ Arquitetura e Estrutura do Repositório

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
│   ├── 00_criacao_banco_de_dados.sql
│   └── ...
├── .gitignore                   # Regras de exclusão do Git
├── LICENSE                      # Licença MIT
├── README.md                    # Documentação do Projeto
└── requirements.txt             # Dependências e Bibliotecas do Python
```
💻 Módulos do Pipeline AnalíticoNotebookFoco / MóduloPrincipais Entregas / Artefatos01_analise_exploratoriaAnálise Temporal & EstatísticaMapeamento da evolução temporal (2019–2025), matriz de correlação de Spearman e perfil de oferta por etapa de ensino.02_geoprocessamentoAnálise Espacial InterativaMapas interativos Folium HTML (mapa_interativo_conectividade_mg.html e laboratorios_mg.html) por município.03_modelo_preditivoMachine Learning & Alerta PrecoceTreinamento do RandomForestClassifier, extração da Feature Importance e geração da matriz_alerta_evasao_mg.csv.
---

## 🚀 Como Executar o Projeto Localmente

### 1. Clonar o Repositório e Configurar o Ambiente Virtual

```powershell
# Clonar o repositório
git clone [https://github.com/SEU_USUARIO/Projeto_Educacao_Analytics.git](https://github.com/SEU_USUARIO/Projeto_Educacao_Analytics.git)
cd Projeto_Educacao_Analytics

# Criar o ambiente virtual
python -m venv .venv

# Ativar o ambiente virtual (Windows PowerShell)
.\.venv\Scripts\Activate.ps1

# Instalar as dependências do projeto
pip install -r requirements.txt
```

### 2. Conectar com o SQL Server

Garantir que a instância local do SQL Server esteja com o banco de dados `Educacao_Analytics` e as views da camada analítica devidamente executadas (`Scripts_SQL/`).

---

## 👤 Autor

**Juliano França da Mata**
Graduando em Bacharelado em Ciência de Dados e Inteligência Artificial
Tecnólogo em Gestão de Tecnologia da Informação

---

## 📄 Licença

Este projeto está licenciado sob os termos da licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
