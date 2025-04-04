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
Necessitar baixar o Node.js

```
cd Teste_API

pip install uvicorn
npm install axios
uvicorn main:app --reload

cd Teste_API_front
npm create vue@latest
npm install
npm run dev
```
OBS: A ordem tem que ser respeitada, devido a criação de arquivos que serão utilizados em ações subsequentes