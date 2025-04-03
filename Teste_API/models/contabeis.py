from sqlalchemy import Column, Integer, String, Date
from database import Base

class DemContabil(Base):
    __tablename__ = 'demonstracoes_contabeis'
    
    data_demonstracao = Column(Date, primary_key=True)
    registro_ans = Column(Integer, primary_key=True)
    codigo_contabil = Column(Integer, primary_key=True)
    descricao = Column(String(180))
    valor_saldo_inicial = Column(String(20))
    valor_saldo_final = Column(String(20))