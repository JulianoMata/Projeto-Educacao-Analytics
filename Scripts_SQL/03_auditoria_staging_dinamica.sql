-- ==============================================================================
-- PROJETO: Analytics Educação Básica (INEP)
-- ETAPA: Auditoria de Qualidade de Staging (Dinâmico para Novos Censos)
-- ARQUIVO: 03_auditoria_staging_dinamica.sql
-- ==============================================================================

USE Educacao_Analytics;
GO

-- 🔴 DEFINA O ANO QUE DESEJA AUDITAR AQUI:
DECLARE @Ano VARCHAR(4) = '2025'; 

-- Variáveis para armazenar os comandos dinâmicos
DECLARE @TabelaEscolas VARCHAR(100) = 'microdados_ed_basica_' + @Ano;
DECLARE @TabelaMatriculas VARCHAR(100) = 'microdados_matriculas_' + @Ano;
DECLARE @SQL NVARCHAR(MAX);

PRINT '======================================================================';
PRINT '      INICIANDO AUDITORIA DINÂMICA DOS DADOS BRUTOS DO CENSO ' + @Ano;
PRINT '======================================================================';
PRINT '';

-- ------------------------------------------------------------------------------
-- CHECAGEM 1: Contagem Total de Registros Importados
-- ------------------------------------------------------------------------------
PRINT '🔍 1. Contagem total de registros carregados:';
SET @SQL = N'
SELECT ''' + @TabelaEscolas + ''' AS Tabela, COUNT(*) AS Total_Registros FROM dbo.' + QUOTENAME(@TabelaEscolas) + N'
UNION ALL
SELECT ''' + @TabelaMatriculas + ''' AS Tabela, COUNT(*) AS Total_Registros FROM dbo.' + QUOTENAME(@TabelaMatriculas) + N';';
EXEC sp_executesql @SQL;

-- ------------------------------------------------------------------------------
-- CHECAGEM 2: Validação de Valores Nulos em Chaves Primárias/Relacionais
-- ------------------------------------------------------------------------------
PRINT '🔍 2. Verificando presença de nulos em campos críticos de relacionamento:';
SET @SQL = N'
SELECT 
    SUM(CASE WHEN CO_ENTIDADE IS NULL OR CO_ENTIDADE = '''' THEN 1 ELSE 0 END) AS Escolas_Sem_Codigo,
    SUM(CASE WHEN CO_MUNICIPIO IS NULL OR CO_MUNICIPIO = '''' THEN 1 ELSE 0 END) AS Escolas_Sem_Municipio
FROM dbo.' + QUOTENAME(@TabelaEscolas) + N';';
EXEC sp_executesql @SQL;

SET @SQL = N'
SELECT 
    SUM(CASE WHEN CO_ENTIDADE IS NULL OR CO_ENTIDADE = '''' THEN 1 ELSE 0 END) AS Matriculas_Sem_Codigo_Escola
FROM dbo.' + QUOTENAME(@TabelaMatriculas) + N';';
EXEC sp_executesql @SQL;

-- ------------------------------------------------------------------------------
-- CHECAGEM 3: Análise de Duplicidade na Tabela de Escolas
-- ------------------------------------------------------------------------------
PRINT '🔍 3. Verificando se há códigos de escola (CO_ENTIDADE) duplicados:';
SET @SQL = N'
SELECT 
    CO_ENTIDADE, 
    COUNT(*) AS Repeticoes
FROM dbo.' + QUOTENAME(@TabelaEscolas) + N'
GROUP BY CO_ENTIDADE
HAVING COUNT(*) > 1;';
EXEC sp_executesql @SQL;

PRINT '======================================================================';
PRINT '             FIM DA AUDITORIA - DADOS DE STAGING ' + @Ano + ' OK              ';
PRINT '======================================================================';