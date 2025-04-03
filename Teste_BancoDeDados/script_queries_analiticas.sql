-- Queries analíticas

-- (CONSIDERAÇÕES: depesa = saldo final - saldo inicial, último = mais recente)

-- Maiores despesas no último semestre 
SELECT oa.razao_social, oa.registro_ans, dc.descricao
FROM operadoras_ativas oa
JOIN demonstracoes_contabeis dc ON oa.registro_ans = dc.registro_ans
WHERE dc.data_demonstracao ='2024-10-01'
AND dc.descricao LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
ORDER BY(dc.valor_saldo_final - dc.valor_saldo_inicial) DESC
LIMIT 10;

-- Maiores despesas no último ano
SELECT oa.razao_social, oa.registro_ans, dc.descricao
FROM operadoras_ativas oa
JOIN demonstracoes_contabeis dc ON oa.registro_ans = dc.registro_ans
WHERE dc.data_demonstracao IN ('2024-01-01', '2024-04-01', '2024-07-01', '2024-10-01')
AND dc.descricao LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
ORDER BY(dc.valor_saldo_final - dc.valor_saldo_inicial) DESC
LIMIT 10;