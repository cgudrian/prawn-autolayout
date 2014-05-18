require 'prawn'

module Prawn

  module AutoLayout

    class Frame
      def initialize(document, opts, content_block)
        @document      = document
        @children      = []
        @content_block = content_block
      end

      def layout(top, left, width, height)
        @document.bounding_box [top, left], width: width, height: height do
          @content_block.call if @content_block
          layout_children(top, left, width, height)
        end
      end

      def add_child(frame)
        @children << frame
      end

      def layout_children(top, left, width, height)
        width = 1.0 * width / @children.count
        @children.each do |c|
          c.layout(top, left, width, height)
          left += width
        end
      end
    end

    class Engine

      def initialize(document, content_block)
        @document   = document
        @root_frame = Frame.new(@document, {}, nil)
        content_block.call(self)
        layout
      end

      def frame(opts={}, &content_block)
        @root_frame.add_child(Frame.new(@document, opts, content_block))
      end

      private

      def layout
        b = @document.bounds
        @root_frame.layout(b.top, b.left, b.width, b.height)
      end

    end

  end


  class Document

    def auto_layout(&content_block)
      AutoLayout::Engine.new(self, content_block)
    end

  end
end