require './lib.rb'

page = WebPage.new('http://kresimirbojcic.com/2011/11/19/dependency-injection-in-ruby.html')

links = LinkParser.new(page.contents, page.host).get_links

links.each do |l|
    puts l
end
