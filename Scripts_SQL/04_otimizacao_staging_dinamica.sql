-- ==============================================================================
-- PROJETO: Analytics Educação Básica (INEP)
-- ETAPA: Criação de Índices em Staging (Dinâmico para Novos Censos)
-- ARQUIVO: 04_otimizacao_staging_dinamica.sql
-- ==============================================================================

USE Educacao_Analytics;
GO

-- 🔴 DEFINA O ANO QUE DESEJA INDEXAR AQUI:
DECLARE @Ano VARCHAR(4) = '2025';

DECLARE @TabelaEscolas VARCHAR(100) = 'microdados_ed_basica_' + @Ano;
DECLARE @TabelaMatriculas VARCHAR(100) = 'microdados_matriculas_' + @Ano;
DECLARE @SQL NVARCHAR(MAX);

PRINT '======================================================================';
PRINT '    OTIMIZANDO TABELAS DE STAGING COM ÍNDICES - CENSO ' + @Ano;
PRINT '======================================================================';
PRINT '';

-- 1. Índice para a Tabela de Escolas
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ed_basica_' + @Ano + '_entidade' AND object_id = OBJECT_ID('dbo.microdados_ed_basica_' + @Ano))
BEGIN
    SET @SQL = N'CREATE NONCLUSTERED INDEX IX_ed_basica_' + @Ano + N'_entidade ON dbo.' + QUOTENAME(@TabelaEscolas) + N' (CO_ENTIDADE);';
    EXEC sp_executesql @SQL;
    PRINT '✅ Índice IX_ed_basica_' + @Ano + '_entidade criado com sucesso.';
END
ELSE
BEGIN
    PRINT '⚠️ O índice IX_ed_basica_' + @Ano + '_entidade já existe.';
END;

-- 2. Índice para a Tabela de Matrículas
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_matriculas_' + @Ano + '_entidade' AND object_id = OBJECT_ID('dbo.microdados_matriculas_' + @Ano))
BEGIN
    SET @SQL = N'CREATE NONCLUSTERED INDEX IX_matriculas_' + @Ano + N'_entidade ON dbo.' + QUOTENAME(@TabelaMatriculas) + N' (CO_ENTIDADE);';
    EXEC sp_executesql @SQL;
    PRINT '✅ Índice IX_matriculas_' + @Ano + '_entidade criado com sucesso.';
END
ELSE
BEGIN
    PRINT '⚠️ O índice IX_matriculas_' + @Ano + '_entidade já existe.';
END;

PRINT '';
PRINT '======================================================================';
PRINT '                 ÍNDICES DE STAGING ATUALIZADOS                       ';
PRINT '======================================================================';
GO