require 'prawn'

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

    class Frame
      def initialize(engine, opts, content_block)
        @engine        = engine
        @children      = []
        @content_block = content_block
      end

      def layout(bounds)
        @engine.frame_context(self, bounds) do
          @content_block.call if @content_block
          layout_children(bounds.reset_origin) if @children.count
        end
      end

      def add_child(frame)
        @children << frame
      end

      def layout_children(bounds)
        bounds = bounds.scale_width(1.0 / @children.count)
        @children.each do |c|
          c.layout(bounds)
          bounds = bounds.move_right
        end
      end

    end

    class Engine
      def initialize(document, content_block)
        @document      = document
        @current_frame = create_root_frame
        content_block.call(self)
        @current_frame.layout(Bounds.for_document(document))
      end

      def frame(opts={}, &content_block)
        @current_frame.add_child(Frame.new(self, opts, content_block))
      end

      def frame_context(frame, bounds)
        @current_frame = frame
        @document.bounding_box(bounds.top_left, width: bounds.width, height: bounds.height) do
          yield
        end
      end

      private

      def create_root_frame
        Frame.new(self, {}, nil)
      end
    end

  end

  class Document
    def auto_layout(&content_block)
      AutoLayout::Engine.new(self, content_block)
    end
  end
end