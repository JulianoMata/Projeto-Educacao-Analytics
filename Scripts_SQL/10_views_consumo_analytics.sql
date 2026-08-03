-- ==============================================================================
-- PROJETO: Analytics Educação Básica (INEP)
-- ETAPA: Camada de Consumo (Views de Negócio / Analytics)
-- ARQUIVO: 10_views_consumo_analytics.sql
-- ==============================================================================

USE Educacao_Analytics;
GO

PRINT '======================================================================';
PRINT '         CRIANDO AS VIEWS DE CONSUMO PARA PYTHON / POWER BI           ';
PRINT '======================================================================';
PRINT '';

-- 1. VIEW NACIONAL CONSOLIDADA
IF OBJECT_ID('dbo.vw_fato_educacao_nacional', 'V') IS NOT NULL
    DROP VIEW dbo.vw_fato_educacao_nacional;
GO

PRINT '🚀 Criando View Nacional (vw_fato_educacao_nacional)...';
GO
CREATE VIEW dbo.vw_fato_educacao_nacional AS
SELECT 
    f.NU_ANO_CENSO AS Ano,
    f.CO_ENTIDADE AS Codigo_Escola,
    e.NO_ENTIDADE AS Nome_Escola,
    l.NO_MUNICIPIO AS Municipio,
    l.SG_UF AS Estado,
    d.DS_DEPENDENCIA AS Rede_Ensino,
    CASE WHEN e.TP_LOCALIZACAO = 1 THEN 'Urbana' ELSE 'Rural' END AS Localizacao,
    f.QT_MAT_BAS AS Total_Matriculas,
    f.QT_DOC_BAS AS Total_Docentes, -- Disponível de 2019 a 2024
    f.IN_INTERNET AS Possui_Internet,
    f.IN_BANDA_LARGA AS Possui_Banda_Larga,
    f.IN_LABORATORIO_INFORMATICA AS Possui_Lab_Informatica,
    f.IN_BIBLIOTECA AS Possui_Biblioteca,
    f.IN_AGUA_POTAVEL AS Possui_Agua_Potavel,
    f.IN_ENERGIA_INEXISTENTE AS Energia_Inexistente,
    f.IN_ESGOTO_INEXISTENTE AS Esgoto_Inexistente
FROM dbo.fato_censo_escolar f
INNER JOIN dbo.dim_escola e ON f.CO_ENTIDADE = e.CO_ENTIDADE
INNER JOIN dbo.dim_localizacao l ON f.CO_MUNICIPIO = l.CO_MUNICIPIO
INNER JOIN dbo.dim_dependencia d ON f.TP_DEPENDENCIA = d.TP_DEPENDENCIA;
GO

-- 2. VIEW FILTRADA PARA MINAS GERAIS (Foco de Análise Rápida)
IF OBJECT_ID('dbo.vw_fato_educacao_mg', 'V') IS NOT NULL
    DROP VIEW dbo.vw_fato_educacao_mg;
GO

PRINT '🚀 Criando View Focada em MG (vw_fato_educacao_mg)...';
GO
CREATE VIEW dbo.vw_fato_educacao_mg AS
SELECT * 
FROM dbo.vw_fato_educacao_nacional
WHERE Estado = 'MG';
GO

PRINT '======================================================================';
PRINT '             VIEWS DE CONSUMO CONFIGURADAS COM SUCESSO                ';
PRINT '======================================================================';