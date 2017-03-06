require "hatebu/rss"

module Hatebu
  class Hatebu
    attr_reader :items
    
    DATA = {
      "総合" => "http://b.hatena.ne.jp/hotentry.rss",
      "世の中" => "http://b.hatena.ne.jp/hotentry/social.rss",
      "政治と経済" => "http://b.hatena.ne.jp/hotentry/economics.rss",
      "暮らし" => "http://b.hatena.ne.jp/hotentry/life.rss",
      "学び" => "http://b.hatena.ne.jp/hotentry/knowledge.rss",
      "テクノロジー" => "http://b.hatena.ne.jp/hotentry/it.rss",
      "アニメとゲーム" => "http://b.hatena.ne.jp/hotentry/game.rss",
      "エンタメ" => "http://b.hatena.ne.jp/hotentry/entertainment.rss",
      "おもしろ" => "http://b.hatena.ne.jp/hotentry/fun.rss",
      "動画" => "http://b.hatena.ne.jp/video.rss",
    }

    def self.category(name)
      Hatebu.new(DATA[name])
    end

    def self.search(kind, query, opt)
      opt[:q] = query
      opt[:mode] = "rss"
      Hatebu.new("http://b.hatena.ne.jp/search/#{kind}?#{URI.encode_www_form opt}")
    end

    def initialize(url)
      @items = RSS.parse(url).items.map { |e| Item.new e }
    end
    
    class Item
      def initialize(data)
        @data = data
      end
      
      def title
        @data.title
      end
      
      def link
        @data.link
      end
      
      def description
        @data.description
      end
      
      def encoded
        @data.encoded
      end
      
      def entry_url
        "hatenabookmark:/entry?url=#{link}"
      end
      
      def l_astr
        AttrString.new(title, link: link)
      end
      
      def b_astr
        AttrString.new("[B]", link: entry_url)
      end
    end
  end
end

if __FILE__ == $0
  def show_bm(category)
    h = Hatebu.new(category)
    h.items.take(3).each do |e|
      print e.l_astr, " ", e.b_astr, "\n"
      puts e.description
      puts
    end
  end
  
  show_bm "総合"
  show_bm "動画"
end
