require 'open-uri'
require 'nokogiri'

class Crawler
    attr_accessor :to_crawl

    def initialize(seed)
        @seed = WebPage.new(seed)
        @to_crawl = []
        @crawled = []
        @keywords = KeywordRepo.new
    end

    def crawl
        start_seed
    end

    private

    def start_seed
        @to_crawl = @to_crawl + LinkParser.new(@seed.contents,@seed.host).get_links
    end

end

class KeywordRepo
    attr_accessor :keywords

    def initialize
        @keywords = {}
    end

    def add_keyword(keyword)
        @keywords[keyword] = []
    end

    def add_link_to(keyword, link)
        @keywords[keyword] << link
    end

end

class LinkParser

    def initialize(string,host='')
        @string = string
        @host = host
    end

    def get_links
        ensure_linkable(get_raw_links)
    end

    private

    def get_raw_links
        @string.scan(/<a.+?href=['"](.+?)['"]/).flatten
    end

    def ensure_linkable(links)
        links.map do |link|
            if link.downcase.include?("http://")
                link
            else
                "http://#{@host}#{link}"
            end
        end
    end

end

class WebPage
    attr_accessor :contents, :host

    def initialize(uri)
        @uri = uri
        @contents = open(@uri) { |f| f.read }
        @host = URI.parse(@uri).host
    end

end

class KeywordParser
    def initialize(uri)
        @content = Nokogiri::HTML(open('http://www.nytimes.com/'))
        @parsed_content = parse_content
    end


    def get_keywords
        @parsed_content.split(' ')
    end

    private
    def parse_content
        get_tag('p')
    end

    def get_tag(tag)
        @content.css(tag).map(&:text).join
    end
end
