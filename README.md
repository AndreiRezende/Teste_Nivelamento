# Teste_Nivelamento Intuitive Care

## Descrição
Desenvolvimento dos testes solicitados no processo seletivo da empresa, contendo:
- Módulo de web scraping para coleta de documentos
- Transformação de dados (PDF → CSV)
- Banco de dados com queries analíticas
- API RESTful com interface web

## Tecnologias

### Etapa 1
- Scrapy
- Requests

### Etapa 2
- Pdfminer
- Pandas

### Etapa 3
- PostgreSQL

### Etapa 4
- Vue.js
- Axios
- FastAPI
- SQLAlchemy
- PostgreSQL
- Node.js
- Vite

### Geral
- Python

## Como executar

### Etapa 1
```
pip install scrapy
pip install requests

cd Teste_WebScraping
scrapy crawl anexos_downloader
```
### Etapa 2
```
pip install pdfminer pandas

cd Teste_TransformacaoDeDados
python pdf_to_csv_py
```
### Etapa 3
Nessa etapa é preciso baixar o postgreSQL e rodar as scripts .sql contidas na pasta Teste_BandoDeDados

### Etapa 4
É necessário baixar o Node.js e alterar a variável URL_DATABASE em database.py de acordo com suas configs do banco de dados (postgreSQL)

#### Backend - FastAPI
```
cd Teste_API
pip install fastapi uvicorn sqlalchemy psycopg2
uvicorn main:app --reload
```
#### Frontend - Vue.js (Em outro terminal)
```
cd Teste_API_front/intuitive_care-project
npm install
npm run dev
```
OBS: A ordem tem que ser respeitada, devido a criação de arquivos que serão utilizados em ações subsequentes
