-- TABELA DE DOMÍNIO
CREATE TABLE operadoras_ativas (
    registro_ans INT PRIMARY KEY,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    razao_social VARCHAR(140) NOT NULL,
    nome_fantasia VARCHAR(140),
    modalidade VARCHAR(40) NOT NULL,
    logradouro VARCHAR(40) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(40),
    bairro VARCHAR(30) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    UF CHAR(2) NOT NULL,
    CEP CHAR(8) NOT NULL,
    DDD CHAR(4),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    email VARCHAR(255),
    representante VARCHAR(50),
    cargo_representante VARCHAR(40),
    regiao_comercializacao INT,
    data_registro DATE NOT NULL,

    CONSTRAINT ck_uf CHECK (UF IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS',
    'MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'))
);

-- Provavelmente uma Tabela de Junção
CREATE TABLE demonstracoes_contabeis (
    data_demonstracao DATE NOT NULL,
    registro_ans INT NOT NULL,
    codigo_contabil INT NOT NULL,
    descricao VARCHAR(180),
    valor_saldo_inicial VARCHAR(20),
    valor_saldo_final VARCHAR(20),

	CONSTRAINT pk_demonstracoes_contabeis PRIMARY KEY (registro_ans, codigo_contabil, data_demonstracao)

    -- Chave estrangeira referenciando operadoras_ativas
	-- Por mais que acredito ser o correto, não pode ser feito, existe demonstraces contabeis com registro_ans que não existe em operadoras ativas
	-- Provavelmente a operadora nao esta mais ativa.
    -- CONSTRAINT fk_registro_ans FOREIGN KEY (registro_ans) REFERENCES operadoras_ativas(registro_ans) ON DELETE CASCADE
)
PARTITION BY LIST (data_demonstracao);
-- Criar particionamento baseado nos trimestres de cada ano, devido a grande quantidade de linhas, otimiza as consultas,
-- visto que as consultas solicitadas envolve datas.

CREATE TABLE demonstracoes_contabeis_q1 PARTITION OF demonstracoes_contabeis FOR VALUES IN ('2023-01-01');
CREATE TABLE demonstracoes_contabeis_q2 PARTITION OF demonstracoes_contabeis FOR VALUES IN ('2023-04-01');
CREATE TABLE demonstracoes_contabeis_q3 PARTITION OF demonstracoes_contabeis FOR VALUES IN ('2023-07-01');
CREATE TABLE demonstracoes_contabeis_q4 PARTITION OF demonstracoes_contabeis FOR VALUES IN ('2023-10-01');
CREATE TABLE demonstracoes_contabeis_q5 PARTITION OF demonstracoes_contabeis FOR VALUES IN ('2024-01-01');
CREATE TABLE demonstracoes_contabeis_q6 PARTITION OF demonstracoes_contabeis FOR VALUES IN ('2024-04-01');
CREATE TABLE demonstracoes_contabeis_q7 PARTITION OF demonstracoes_contabeis FOR VALUES IN ('2024-07-01');
CREATE TABLE demonstracoes_contabeis_q8 PARTITION OF demonstracoes_contabeis FOR VALUES IN ('2024-10-01');

-- Criando índices para otimizar consultas baseando-se na minha interpretação de quais atributos podem ser mais utilizados em Queries
CREATE INDEX idx_registro_ans ON demonstracoes_contabeis(registro_ans);
CREATE INDEX idx_pk_composta ON demonstracoes_contabeis(registro_ans, data_demonstracao, codigo_contabil);


CREATE TEMP TABLE temp_demonstracoes_contabeis (
    data_demonstracao VARCHAR(10),
    registro_ans INT NOT NULL,
    codigo_contabil INT NOT NULL,
    descricao VARCHAR(180),
    valor_saldo_inicial VARCHAR(20),
    valor_saldo_final VARCHAR(20)
);

GRANT pg_read_server_files TO postgres;

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

INSERT INTO demonstracoes_contabeis (
    data_demonstracao,
    registro_ans,
    codigo_contabil,
    descricao,
    valor_saldo_inicial,
    valor_saldo_final
)
SELECT 
    TO_DATE(data_demonstracao, 'DD/MM/YYYY') AS data_demonstracao,
    registro_ans,
    codigo_contabil,
    descricao,
    valor_saldo_inicial,
    valor_saldo_final
FROM temp_demonstracoes_contabeis;

SELECT oa.razao_social, oa.registro_ans, dc.descricao
FROM operadoras_ativas oa
JOIN demonstracoes_contabeis dc ON oa.registro_ans = dc.registro_ans
WHERE dc.data_demonstracao ='2024-10-01'
AND dc.descricao LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
ORDER BY(dc.valor_saldo_final - dc.valor_saldo_inicial) DESC
LIMIT 10;

SELECT oa.razao_social, oa.registro_ans, dc.descricao
FROM operadoras_ativas oa
JOIN demonstracoes_contabeis dc ON oa.registro_ans = dc.registro_ans
WHERE dc.data_demonstracao IN ('2024-01-01', '2024-04-01', '2024-07-01', '2024-10-01')
AND dc.descricao LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
ORDER BY(dc.valor_saldo_final - dc.valor_saldo_inicial) DESC
LIMIT 10;