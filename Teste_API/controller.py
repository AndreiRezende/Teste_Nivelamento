from fastapi import APIRouter, Depends
from repository import Repository
from database import database

router = APIRouter(prefix='/operadora')

@router.get('/')
def get_operadora(
    descricao: str, 
    data: str, 
    db = Depends(database)  # Usar get_db em vez de database
):
    repo = Repository(db)
    return repo.find_operadora_by_despesa(descricao, data)

  