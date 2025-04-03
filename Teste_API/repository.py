from sqlalchemy import text

class Repository:
    def __init__(self, db):
        self.db = db

    def find_operadora_by_despesa(self, descricao: str, data: str):
        query = text("""
            SELECT 
                oa.razao_social, 
                oa.registro_ans, 
                dc.descricao,
                (dc.valor_saldo_final::numeric - dc.valor_saldo_inicial::numeric) as diferenca
            FROM operadoras_ativas oa
            JOIN demonstracoes_contabeis dc ON oa.registro_ans = dc.registro_ans
            WHERE dc.data_demonstracao = :data
            AND dc.descricao LIKE :descricao
            ORDER BY diferenca DESC
            LIMIT 10
        """)
        
        result = self.db.execute(query, {
            "descricao": f"%{descricao}%", 
            "data": data
        })
        
        # Converter explicitamente para lista de dicionários
        columns = result.keys()
        return [dict(zip(columns, row)) for row in result.fetchall()]


