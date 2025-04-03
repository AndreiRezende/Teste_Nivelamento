from sqlalchemy import Column, Integer, String, Date, CHAR
from database import Base

class OperadoraAtiva(Base):
    __tablename__ = 'operadoras_ativas'
    
    registro_ans = Column(Integer, primary_key=True)
    cnpj = Column(CHAR(14), unique=True, nullable=False)
    razao_social = Column(String(140), nullable=False)
    nome_fantasia = Column(String(140))
    modalidade = Column(String(40), nullable=False)
    logradouro = Column(String(40), nullable=False)
    numero = Column(String(20), nullable=False)
    complemento = Column(String(40))
    bairro = Column(String(30), nullable=False)
    cidade = Column(String(30), nullable=False)
    uf = Column(CHAR(2), nullable=False)
    cep = Column(CHAR(8), nullable=False)
    ddd = Column(CHAR(4))
    telefone = Column(String(20))
    fax = Column(String(20))
    email = Column(String(255))
    representante = Column(String(50))
    cargo_representante = Column(String(40))
    regiao_comercializacao = Column(Integer)
    data_registro = Column(Date, nullable=False)