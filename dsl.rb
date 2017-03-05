# Hatebu DSL functions.
require "hatebu/hatebu"

module Hatebu
  module DSL
    def history(filename, &block)
      @history = JsonFile.new(filename)
      block.call
      @history.save
      @history = nil
    end
    
    def category(name)
      get_unviewed(Hatebu.new(name).items)
    end

    def show(data)
      if data.is_a? Array
        data.each { |e| show e }
      else
        print data.l_astr, " ", data.b_astr, "\n"
        puts data.description
        puts
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
