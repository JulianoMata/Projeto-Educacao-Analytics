-- ==============================================================================
-- PROJETO: Analytics Educação Básica (INEP)
-- ETAPA: Camada de Transformação (Consolidação Censo 2025 - CORRIGIDO)
-- ARQUIVO: 07_view_consolidacao_2025.sql
-- ==============================================================================

USE Educacao_Analytics;
GO

PRINT '======================================================================';
PRINT '    ATUALIZANDO A VIEW DE CONSOLIDAÇÃO DE 2025 (SUM DE MATRÍCULAS)    ';
PRINT '======================================================================';
PRINT '';

IF OBJECT_ID('dbo.vw_microdados_consolidado_2025', 'V') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_microdados_consolidado_2025;
END;
GO

CREATE VIEW dbo.vw_microdados_consolidado_2025 AS
WITH cte_matriculas_2025 AS (
    -- CORREÇÃO: Agora somamos a coluna de métrica em vez de contar as linhas
    SELECT 
        CAST(CO_ENTIDADE AS BIGINT) AS CO_ENTIDADE,
        SUM(CAST(QT_MAT_BAS AS INT)) AS QT_MAT_BAS
    FROM dbo.microdados_matriculas_2025
    WHERE CO_ENTIDADE IS NOT NULL
    GROUP BY CO_ENTIDADE
)
SELECT 
    2025 AS NU_ANO_CENSO,
    CAST(esc.CO_ENTIDADE AS BIGINT) AS CO_ENTIDADE,
    CAST(esc.NO_ENTIDADE AS VARCHAR(150)) AS NO_ENTIDADE,
    CAST(esc.CO_MUNICIPIO AS INT) AS CO_MUNICIPIO,
    CAST(esc.TP_DEPENDENCIA AS INT) AS TP_DEPENDENCIA,
    ISNULL(mat.QT_MAT_BAS, 0) AS QT_MAT_BAS,
    NULL AS QT_DOC_BAS, 
    CAST(esc.IN_INTERNET AS INT) AS IN_INTERNET,
    CAST(esc.IN_BANDA_LARGA AS INT) AS IN_BANDA_LARGA,
    CAST(esc.IN_LABORATORIO_INFORMATICA AS INT) AS IN_LABORATORIO_INFORMATICA,
    CAST(esc.IN_BIBLIOTECA AS INT) AS IN_BIBLIOTECA,
    CAST(esc.IN_AGUA_POTAVEL AS INT) AS IN_AGUA_POTAVEL,
    CASE WHEN esc.IN_ENERGIA_INEXISTENTE = 1 THEN 1 ELSE 0 END AS IN_ENERGIA_INEXISTENTE,
    CASE WHEN esc.IN_ESGOTO_INEXISTENTE = 1 THEN 1 ELSE 0 END AS IN_ESGOTO_INEXISTENTE
FROM dbo.microdados_ed_basica_2025 esc
LEFT JOIN cte_matriculas_2025 mat ON CAST(esc.CO_ENTIDADE AS BIGINT) = mat.CO_ENTIDADE
WHERE esc.TP_DEPENDENCIA IN (2, 3);
GO

PRINT '✅ View dbo.vw_microdados_consolidado_2025 atualizada com sucesso!';
PRINT '======================================================================';
GO