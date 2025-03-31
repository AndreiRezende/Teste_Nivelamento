import os
import zipfile
  
def extrair_tabelas_pdf():
    # Configurações de caminhos e nomes de arquivo
    caminho_zip = os.path.join('..', 'Teste_WebScraping', 'anexos_compactados.zip')
    pasta_temp = 'temp_pdfs'
    pdf_alvo = 'Anexo_1.pdf'
    
    # Extrair PDF do ZIP
    with zipfile.ZipFile(caminho_zip, 'r') as zip_ref:
        zip_ref.extract(pdf_alvo, pasta_temp)
    
    caminho_pdf = os.path.join(pasta_temp, pdf_alvo)
              
if __name__ == '__main__':
    extrair_tabelas_pdf()