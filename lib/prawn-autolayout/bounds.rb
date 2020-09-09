module Prawn
  module AutoLayout
    class Bounds
      attr_accessor :left, :top, :width, :height

      def initialize(left, top, width, height)
        @left, @top, @width, @height = left, top, width, height
      end

      def move_right
        Bounds.new(@left + @width, @top, @width, @height)
      end

      def move_down
        Bounds.new(@left, @top - @height, @width, @height)
      end

      def scale_width(factor)
        Bounds.new(@left, @top, @width * factor, @height)
      end

      def reset_origin
        Bounds.new(0, @height, @width, @height)
      end

      def top_left
        [left, top]
      end

      def to_s
        "[#{@left}, #{@top}], width: #{@width}, height: #{@height}"
      end

      def self.for_document(document)
        b = document.bounds
        Bounds.new(b.left, b.top, b.width, b.height)
      end
    end
  end
end
