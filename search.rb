require './lib.rb'

c = Crawler.new('http://kresimirbojcic.com/2011/11/19/dependency-injection-in-ruby.html')

c.crawl

page = WebPage.new('http://kresimirbojcic.com/2011/11/19/dependency-injection-in-ruby.html')

k = KeywordParser.new(page.contents)

k.get_keywords.each do |k|
    puts k
end
