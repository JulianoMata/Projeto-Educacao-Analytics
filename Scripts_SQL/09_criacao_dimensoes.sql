/* -----------------------------------------------------------------------------
   PROJETO: Analytics Educação Básica (INEP)
   ETAPA: Modelagem Dimensional (Criação das Tabelas Dimensão)
   ARQUIVO: 09_criacao_dimensoes.sql
   OBJETIVO: Extrair e estruturar as dimensões com dados do território nacional.
----------------------------------------------------------------------------- */

USE Educacao_Analytics;
GO

-------------------------------------------------------------------------------
-- 1. Dimensão Localização (Municípios e UFs únicos a partir de Staging)
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.dim_localizacao', 'U') IS NOT NULL
    DROP TABLE dbo.dim_localizacao;
GO

PRINT '🚀 Criando dim_localizacao (Mapeamento de Municípios do Brasil)...';

-- Buscamos do último ano estável da staging antiga que possui as siglas de UF textuais
SELECT 
    CAST(CO_MUNICIPIO AS INT) AS CO_MUNICIPIO,
    CAST(MAX(NO_MUNICIPIO) AS VARCHAR(100)) AS NO_MUNICIPIO,
    CAST(MAX(CO_UF) AS INT) AS CO_UF,
    CAST(MAX(SG_UF) AS VARCHAR(2)) AS SG_UF
INTO dbo.dim_localizacao
FROM dbo.microdados_ed_basica_2024
WHERE CO_MUNICIPIO IS NOT NULL
GROUP BY CO_MUNICIPIO;

ALTER TABLE dbo.dim_localizacao ALTER COLUMN CO_MUNICIPIO INT NOT NULL;
ALTER TABLE dbo.dim_localizacao ADD CONSTRAINT PK_dim_localizacao PRIMARY KEY (CO_MUNICIPIO);
GO

-------------------------------------------------------------------------------
-- 2. Dimensão Escola (Cadastro Único de Entidades Nacional)
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.dim_escola', 'U') IS NOT NULL
    DROP TABLE dbo.dim_escola;
GO

PRINT '🚀 Criando dim_escola (Cadastro Único de Escolas Públicas)...';

-- Combinamos a Fato com a Staging de 2024 para obter o TP_LOCALIZACAO (Urbana/Rural)
SELECT 
    f.CO_ENTIDADE,
    MAX(f.NO_ENTIDADE) AS NO_ENTIDADE,
    MAX(f.CO_MUNICIPIO) AS CO_MUNICIPIO,
    MAX(f.TP_DEPENDENCIA) AS TP_DEPENDENCIA,
    ISNULL(CAST(MAX(stg.TP_LOCALIZACAO) AS INT), 1) AS TP_LOCALIZACAO -- Fallback para Urbana caso não encontre
INTO dbo.dim_escola
FROM dbo.fato_censo_escolar f
LEFT JOIN dbo.microdados_ed_basica_2024 stg ON f.CO_ENTIDADE = stg.CO_ENTIDADE
GROUP BY f.CO_ENTIDADE;

ALTER TABLE dbo.dim_escola ALTER COLUMN CO_ENTIDADE BIGINT NOT NULL;
ALTER TABLE dbo.dim_escola ADD CONSTRAINT PK_dim_escola PRIMARY KEY (CO_ENTIDADE);
GO

-------------------------------------------------------------------------------
-- 3. Dimensão Dependência Administrativa (Tabela de Domínio)
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.dim_dependencia', 'U') IS NOT NULL
    DROP TABLE dbo.dim_dependencia;
GO

PRINT '🚀 Criando dim_dependencia...';

CREATE TABLE dbo.dim_dependencia (
    TP_DEPENDENCIA INT NOT NULL PRIMARY KEY,
    DS_DEPENDENCIA VARCHAR(50) NOT NULL
);

INSERT INTO dbo.dim_dependencia (TP_DEPENDENCIA, DS_DEPENDENCIA)
VALUES 
    (1, 'Federal'),
    (2, 'Estadual'),
    (3, 'Municipal'),
    (4, 'Privada');
GO

PRINT '======================================================================';
PRINT '         TABELAS DE DIMENSÃO CRIADAS E POPULADAS COM SUCESSO          ';
PRINT '======================================================================';