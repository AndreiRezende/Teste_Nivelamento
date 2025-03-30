import scrapy


class AnexosSpider(scrapy.Spider):
    name = "anexos"
    allowed_domains = ["www.gov.br"]
    start_urls = ["https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"]

    def parse(self, response):
        pass
