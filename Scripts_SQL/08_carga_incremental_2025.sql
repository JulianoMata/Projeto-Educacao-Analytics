-- ==============================================================================
-- PROJETO: Analytics Educação Básica (INEP)
-- ETAPA: Carga Incremental (Censo 2025) - ESCOPO NACIONAL
-- ARQUIVO: 08_carga_incremental_2025.sql
-- ==============================================================================

USE Educacao_Analytics;
GO

PRINT '======================================================================';
PRINT '        INICIANDO CARGA INCREMENTAL DA FATO - CENSO 2025              ';
PRINT '======================================================================';
PRINT '';

-- Limpeza preventiva do ano específico para garantir idempotência
DELETE FROM dbo.fato_censo_escolar WHERE NU_ANO_CENSO = 2025;
PRINT '♻️ Registros antigos de 2025 limpos por segurança.';
PRINT '';

PRINT '🚀 Injetando dados de 2025 na Fato Nacional...';

INSERT INTO dbo.fato_censo_escolar (
    NU_ANO_CENSO, CO_ENTIDADE, NO_ENTIDADE, CO_MUNICIPIO, TP_DEPENDENCIA,
    QT_MAT_BAS, QT_DOC_BAS, IN_INTERNET, IN_BANDA_LARGA, 
    IN_LABORATORIO_INFORMATICA, IN_BIBLIOTECA, IN_AGUA_POTAVEL, 
    IN_ENERGIA_INEXISTENTE, IN_ESGOTO_INEXISTENTE
)
SELECT 
    NU_ANO_CENSO,
    CO_ENTIDADE,
    NO_ENTIDADE,
    CO_MUNICIPIO,
    TP_DEPENDENCIA,
    QT_MAT_BAS,
    QT_DOC_BAS,
    IN_INTERNET,
    IN_BANDA_LARGA,
    IN_LABORATORIO_INFORMATICA,
    IN_BIBLIOTECA,
    IN_AGUA_POTAVEL,
    IN_ENERGIA_INEXISTENTE,
    IN_ESGOTO_INEXISTENTE
FROM dbo.vw_microdados_consolidado_2025;
GO

-- Validação geral de toda a série histórica nacional na Fato
PRINT '';
PRINT '📊 Conferência final da volumetria nacional por ano (2019 a 2025):';
SELECT 
    NU_ANO_CENSO AS Ano,
    COUNT(*) AS Total_Escolas,
    SUM(QT_MAT_BAS) AS Total_Matriculas
FROM dbo.fato_censo_escolar
GROUP BY NU_ANO_CENSO
ORDER BY NU_ANO_CENSO DESC;
GO

PRINT '======================================================================';
PRINT '             CARGA INCREMENTAL DE 2025 CONCLUÍDA                      ';
PRINT '======================================================================';
GO