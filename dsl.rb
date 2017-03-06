# Hatebu DSL functions.
require "hatebu/hatebu"
require "hatebu/json_file"

module Hatebu
  module DSL
    def history(filename, &block)
      @history = JsonFile.new(filename)
      block.call
      @history.save
      @history = nil
    end
    
    def category(name)
      get_unviewed(Hatebu.category(name).items)
    end

    def tag(query, opt = {safe: "on"})
      get_unviewed(Hatebu.tag(query, opt).items)
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
