require './lib.rb'

c = Crawler.new('http://kresimirbojcic.com/2011/11/19/dependency-injection-in-ruby.html')

c.crawl

c.to_crawl.each do |link|
    p link
end

