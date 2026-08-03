-- Evolução temporal de escolas e matrículas em Januária (Redes Estadual e Municipal)
SELECT 
    f.NU_ANO_CENSO AS Ano_Censo,
    COUNT(DISTINCT f.CO_ENTIDADE) AS Total_Escolas_Unicas,
    SUM(CAST(ISNULL(f.QT_MAT_BAS, 0) AS BIGINT)) AS Total_Matriculas,
    SUM(CASE WHEN ISNULL(f.IN_INTERNET, 0) = 0 THEN 1 ELSE 0 END) AS Escolas_Sem_Internet,
    SUM(CASE WHEN ISNULL(f.IN_LABORATORIO_INFORMATICA, 0) = 0 THEN 1 ELSE 0 END) AS Escolas_Sem_Lab_Info
FROM dbo.fato_censo_escolar f
INNER JOIN dbo.dim_localizacao l ON f.CO_MUNICIPIO = l.CO_MUNICIPIO
WHERE l.NO_MUNICIPIO LIKE '%Januária%'
  AND l.SG_UF = 'MG'
  AND f.TP_DEPENDENCIA IN (2, 3) -- Redes Estadual e Municipal
GROUP BY f.NU_ANO_CENSO
ORDER BY f.NU_ANO_CENSO ASC;