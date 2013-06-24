require 'open-uri'

class Crawler

    @@to_search = []
    @@searched = []

    def initialize(seed)
        @seed = seed
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
