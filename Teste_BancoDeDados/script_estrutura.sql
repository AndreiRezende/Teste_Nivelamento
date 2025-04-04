CREATE DATABASE IF NOT EXISTS IntuitiveCare;

USE IntuitiveCare;

-- TABELA DE DOMÍNIO
CREATE TABLE IF NOT EXISTS operadoras_ativas (
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
CREATE TABLE  IF NOT EXISTS demonstracoes_contabeis (
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

-- Criando índices para otimizar consultas baseando-se nas Queries solicitadas
CREATE INDEX idx_registro_ans ON operadoras_ativas(registro_ans);
CREATE INDEX idx_querie_analitica ON demonstracoes_contabeis(data_demonstracao, descricao);

-- Tabela temporária
CREATE TEMP TABLE temp_demonstracoes_contabeis (
    data_demonstracao VARCHAR(10),
    registro_ans INT NOT NULL,
    codigo_contabil INT NOT NULL,
    descricao VARCHAR(180),
    valor_saldo_inicial VARCHAR(20),
    valor_saldo_final VARCHAR(20)
);