GRANT pg_read_server_files TO postgres; -- Permissão para o acesso dos arquivos csv que baixei seguindo orientações da etapa de preparação.

COPY operadoras_ativas FROM 'C:/dados_operadoras/Relatorio_cadop.csv' -- caminho onde os arquivos csv estão baixados na minha máquina
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

COPY demonstracoes_contabeis (data_demonstracao, registro_ans, codigo_contabil, descricao, valor_saldo_inicial, valor_saldo_final)
FROM 'C:/dados_operadoras/1T2023.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

COPY demonstracoes_contabeis (data_demonstracao, registro_ans, codigo_contabil, descricao, valor_saldo_inicial, valor_saldo_final)
FROM 'C:/dados_operadoras/2T2023.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

COPY demonstracoes_contabeis (data_demonstracao, registro_ans, codigo_contabil, descricao, valor_saldo_inicial, valor_saldo_final)
FROM 'C:/dados_operadoras/3T2023.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

COPY demonstracoes_contabeis (data_demonstracao, registro_ans, codigo_contabil, descricao, valor_saldo_inicial, valor_saldo_final)
FROM 'C:/dados_operadoras/1T2024.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

COPY demonstracoes_contabeis (data_demonstracao, registro_ans, codigo_contabil, descricao, valor_saldo_inicial, valor_saldo_final)
FROM 'C:/dados_operadoras/2T2024.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

COPY demonstracoes_contabeis (data_demonstracao, registro_ans, codigo_contabil, descricao, valor_saldo_inicial, valor_saldo_final)
FROM 'C:/dados_operadoras/3T2024.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

COPY demonstracoes_contabeis (data_demonstracao, registro_ans, codigo_contabil, descricao, valor_saldo_inicial, valor_saldo_final)
FROM 'C:/dados_operadoras/4T2024.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

COPY temp_demonstracoes_contabeis (data_demonstracao, registro_ans, codigo_contabil, descricao, valor_saldo_inicial, valor_saldo_final)
FROM 'C:/dados_operadoras/4T2023.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

-- Tratando saldos, valores com vírgula fora do formato padrão para DECIMAL
UPDATE demonstracoes_contabeis
SET valor_saldo_inicial = REPLACE(valor_saldo_inicial, ',', '.'),
	valor_saldo_final = REPLACE(valor_saldo_final, ',', '.');
	
ALTER TABLE demonstracoes_contabeis
ALTER COLUMN valor_saldo_inicial TYPE DECIMAL(15, 2) USING valor_saldo_inicial::DECIMAL(15, 2),
ALTER COLUMN valor_saldo_final TYPE DECIMAL(15, 2) USING valor_saldo_final::DECIMAL(15, 2);

UPDATE temp_demonstracoes_contabeis
SET valor_saldo_inicial = REPLACE(valor_saldo_inicial, ',', '.'),
	valor_saldo_final = REPLACE(valor_saldo_final, ',', '.');
	
ALTER TABLE temp_demonstracoes_contabeis
ALTER COLUMN valor_saldo_inicial TYPE DECIMAL(15, 2) USING valor_saldo_inicial::DECIMAL(15, 2),
ALTER COLUMN valor_saldo_final TYPE DECIMAL(15, 2) USING valor_saldo_final::DECIMAL(15, 2);