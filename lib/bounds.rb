module Prawn
  module AutoLayout
    class Bounds
      attr_accessor :top, :left, :width, :height

      def initialize(top, left, width, height)
        @top, @left, @width, @height = top, left, width, height
      end

      def move_right
        Bounds.new(@top, @left + @width, @width, @height)
      end

      def move_down
        Bounds.new(@top - @height, @left, @width, @height)
      end

      def scale_width(factor)
        Bounds.new(@top, @left, @width * factor, @height)
      end

      def reset_origin
        Bounds.new(@height, 0, @width, @height)
      end

      def top_left
        [left, top]
      end

      def self.for_document(document)
        b = document.bounds
        Bounds.new(b.top, b.left, b.width, b.height)
      end
    end
  end
end
