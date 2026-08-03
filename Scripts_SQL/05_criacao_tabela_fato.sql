-- ==============================================================================
-- PROJETO: Analytics Educação Básica (INEP)
-- ETAPA: Modelagem Dimensional (Estrutura da Fato)
-- ARQUIVO: 05_criacao_tabela_fato.sql
-- ==============================================================================

USE Educacao_Analytics;
GO

PRINT '======================================================================';
PRINT '           CRIANDO A ESTRUTURA DA TABELA FATO CONSOLIDADA             ';
PRINT '======================================================================';
PRINT '';

-- Drop de segurança caso o script seja rodado mais de uma vez
IF OBJECT_ID('dbo.fato_censo_escolar', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.fato_censo_escolar;
    PRINT '♻️ Tabela Fato antiga removida para reconstrução.';
END;

-- Criação da tabela com as colunas métricas e chaves de junção
CREATE TABLE dbo.fato_censo_escolar (
    NU_ANO_CENSO INT NOT NULL,
    CO_ENTIDADE BIGINT NOT NULL,
    NO_ENTIDADE VARCHAR(150) NULL, -- Mantida para capturar o nome histórico na unificação
    CO_MUNICIPIO INT NULL,
    TP_DEPENDENCIA INT NULL,
    QT_MAT_BAS INT NULL,
    QT_DOC_BAS INT NULL, -- Métrica que usaremos no histórico legado
    IN_INTERNET INT NULL,
    IN_BANDA_LARGA INT NULL,
    IN_LABORATORIO_INFORMATICA INT NULL,
    IN_BIBLIOTECA INT NULL,
    IN_AGUA_POTAVEL INT NULL,
    IN_ENERGIA_INEXISTENTE INT NULL,
    IN_ESGOTO_INEXISTENTE INT NULL
);
GO

PRINT '✅ Tabela dbo.fato_censo_escolar criada com sucesso absoluto!';
PRINT '======================================================================';
GO