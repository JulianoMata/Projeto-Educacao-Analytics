USE Educacao_Analytics;
GO

PRINT '======================================================================';
PRINT '     DIAGNÓSTICO E VOLUMETRIA DINÂMICA DE STAGING (SÉRIE HISTÓRICA)   ';
PRINT '======================================================================';
PRINT '';

-- 1. Mapa de Estrutura e Linhas Dinâmico
SELECT 
    t.name AS Tabela_Staging,
    MAX(p.rows) AS Total_Registros,
    COUNT(DISTINCT c.column_id) AS Total_Colunas,
    CASE 
        WHEN t.name LIKE '%matricula%' THEN 'Cadastro de Matrículas (Microdados)'
        WHEN t.name LIKE '%ed_basica%' OR t.name LIKE '%escola%' THEN 'Cadastro de Escolas (Infraestrutura)'
        ELSE 'Outros Arquivos de Staging'
    END AS Classificacao_Dado
FROM sys.tables t
INNER JOIN sys.columns c ON t.object_id = c.object_id
INNER JOIN sys.indexes i ON t.object_id = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
WHERE t.is_ms_shipped = 0 -- Garante que só vai ler tabelas que VOCÊ criou (ignora tabelas do sistema)
GROUP BY t.name
ORDER BY Classificacao_Dado DESC, t.name ASC;
GO