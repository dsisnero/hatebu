# Hatebu DSL functions.
require "hatebu/hatebu"
require "hatebu/json_file"

module Hatebu
  module DSL
    def history(filename, &block)
      @history = JsonFile.new(filename) if filename

      block.call

      if @history
        @history.save
        @history = nil
      end
    end
    
    def category(name)
      get_unviewed(Hatebu.category(name).items)
    end

    def tag(query, opt = {safe: "on"})
      search("tag", query, opt)
    end

    def title(query, opt = {safe: "on"})
      search("title", query, opt)
    end

    def text(query, opt = {safe: "on"})
      search("text", query, opt)
    end

    def search(kind, query, opt = {safe: "on"})
      get_unviewed(Hatebu.search(kind, query, opt).items)
    end

    def show(data)
      if data.is_a? Array
        data.each { |e| show e }
      else
        print data.l_astr, " ", data.b_astr, "\n"
        puts data.description
        puts

        @history.data[data.link] = 1 if @history
      end
    end
    
    private

    def get_unviewed(items)
      if @history
        items.select { |e| !@history.data[e.link] }
      else
        items
      end
    end
  end
end

self.extend Hatebu::DSL
