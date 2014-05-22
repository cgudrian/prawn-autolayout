require_relative 'prawn-autolayout/frame.rb'
require_relative 'prawn-autolayout/bounds.rb'
require_relative 'prawn-autolayout/engine.rb'

module Prawn
  class Document
    def auto_layout(&content_block)
      AutoLayout::Engine.new(self, &content_block)
    end
  end
end
