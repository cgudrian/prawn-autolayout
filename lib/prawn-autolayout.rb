require_relative 'frame.rb'
require_relative 'bounds.rb'
require_relative 'engine.rb'

module Prawn
  class Document
    def auto_layout(&content_block)
      AutoLayout::Engine.new(self, content_block)
    end
  end
end
