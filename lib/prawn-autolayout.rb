require 'prawn-autolayout/frame.rb'
require 'prawn-autolayout/bounds.rb'
require 'prawn-autolayout/engine.rb'

module Prawn
  class Document
    def auto_layout(&content_block)
      AutoLayout::Engine.new(self, &content_block)
    end
  end
end
