import scrapy


class TopSpider(scrapy.Spider):
    name = 'top'
    allowed_domains = ['www.imdb.com']
    start_urls = ['https://www.imdb.com/chart/top']

    def parse(self, response):
        movies = response.css("table tbody.lister-list tr")
        for movie in movies:
            yield {
                "img": movie.css("td.posterColumn a img::attr(src)").get(),
                "title": movie.css("td.titleColumn a::text").get(),
                "year": movie.css("td.titleColumn span::text").get()[1:-1],
                "rating": movie.css("td.imdbRating strong::text").get(),
            }
