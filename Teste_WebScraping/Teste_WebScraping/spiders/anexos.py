import scrapy
import os
import requests

class AnexosSpider(scrapy.Spider):
    name = "anexos_downloader"
    allowed_domains = ["www.gov.br"]
    start_urls = ["https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"]

    def parse(self, response):
        links_pdfs = []
        lista_links = response.xpath("/html/body/div[2]/div[1]/main/div[2]/div/div/div/div/div[2]/div/ol/li")

        for item in lista_links:
            link = item.xpath(".//a/@href").extract_first()
            links_pdfs.append(link)

    