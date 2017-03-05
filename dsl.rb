# Hatebu DSL functions.
require "hatebu/hatebu"

module Hatebu
  module DSL
    def category(name, &block)
      block.call Hatebu.new(name).items
    end
  end
end

self.extend Hatebu::DSL
