module Hatebu
  class RSS
    attr_reader :data
    attr_reader :items
    
    def self.parse(url, count = 30)
      url = "https://query.yahooapis.com/v1/public/yql?" + 
            URI.encode_www_form(
              q: "SELECT title,link,description,encoded FROM rss WHERE url=\"#{url}\" | truncate(count=#{count})",
              format: "json"
            )
      RSS.new Browser.json(url)
    end
    
    def initialize(data)
      @data = data
      @items = @data['query']['results']['item'].map { |e| Item.new e }
    end
    
    class Item
      attr_reader :data
      
      def initialize(data)
        @data = data
      end
      
      def title
        @data["title"]
      end
      
      def link
        @data["link"]
      end
      
      def description
        @data["description"]
      end
      
      def encoded
        @data["encoded"]
      end
    end
  end
end

if __FILE__ == $0
  rss = RSS.parse "http://b.hatena.ne.jp/hotentry.rss"
  rss.items.each do |e|
    p e
  end
end
