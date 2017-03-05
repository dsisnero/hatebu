# Hatebu DSL functions.
require "hatebu/hatebu"

module Hatebu
  module DSL
    def category(name)
      Hatebu.new(name).items
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
  end
end

self.extend Hatebu::DSL
