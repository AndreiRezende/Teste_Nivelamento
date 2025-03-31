import os
import zipfile
from pdfminer.high_level import extract_pages
from pdfminer.layout import LTTextBoxHorizontal, LTRect

def extrair_tabelas_pdf():
    # Configurações de caminhos e nomes de arquivo
    caminho_zip = os.path.join('..', 'Teste_WebScraping', 'anexos_compactados.zip')
    pasta_temp = 'temp_pdfs'
    pdf_alvo = 'Anexo_1.pdf'
    
    # Extrair PDF do ZIP
    with zipfile.ZipFile(caminho_zip, 'r') as zip_ref:
        zip_ref.extract(pdf_alvo, pasta_temp)
    
    caminho_pdf = os.path.join(pasta_temp, pdf_alvo)

    for page_layout in extract_pages(caminho_pdf):

        coordenadas_linhas = [707, 673, 639, 605, 571, 537, 503, 469, 435, 401, 367, 333, 299, 265, 231, 197, 163, 129, 95]

        novos_dados = {
            'PROCEDIMENTO': '',
            'RN (alteração)': '',
            'VIGÊNCIA': '',
            "OD": '',
            "AMB": '',
            "HCO": '',
            "HSO": '',
            "REF": '',
            "PAC": '',
            "DUT": '',
            "SUBGRUPO": '',
            "GRUPO": '',
            "CAPÍTULO": '',
        }
    
        dados_tabela = [novos_dados.copy() for _ in range(len(coordenadas_linhas))]

        # Pular páginas sem elementos de tabela
        if not any(isinstance(element, LTRect) for element in page_layout):
            continue
            
        # Extrair elementos de texto em cada página por meio de coordenadas
        for element in page_layout:
            if isinstance(element, LTTextBoxHorizontal):
                for indice, coordenada in enumerate(coordenadas_linhas):
                    if abs(element.y0 - coordenada) <= 10:
                        if abs(element.x0 - 56) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['PROCEDIMENTO'] = texto_filtrado
                        if abs(element.x0 - 497) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['RN (alteração)'] = texto_filtrado
                        if abs(element.x0 - 547) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['VIGÊNCIA'] = texto_filtrado
                        if abs(element.x0 - 604) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['OD'] = texto_filtrado
                        if abs(element.x0 - 633) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['AMB'] = texto_filtrado
                        if abs(element.x0 - 665) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['HCO'] = texto_filtrado
                        if abs(element.x0 - 697) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['HSO'] = texto_filtrado
                        if abs(element.x0 - 730) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['REF'] = texto_filtrado
                        if abs(element.x0 - 761) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['PAC'] = texto_filtrado
                        if abs(element.x0 - 797) <= 9:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['DUT'] = texto_filtrado
                        if abs(element.x0 - 819) <= 9:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['SUBGRUPO'] = texto_filtrado
                        if abs(element.x0 - 1001) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['GRUPO'] = texto_filtrado
                        if abs(element.x0 - 1184) <= 10:
                            texto = element.get_text()
                            texto_filtrado = texto.replace("\n", "")
                            dados_tabela[indice]['CAPÍTULO'] = texto_filtrado

        dicionarios_filtrados = [
            d for d in dados_tabela
            if not all(valor == '' for valor in d.values())
        ]

if __name__ == '__main__':
    extrair_tabelas_pdf()