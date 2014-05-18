require 'prawn'

module Prawn
  module AutoLayout

    class Frame
      def initialize(engine, opts, content_block)
        @engine        = engine
        @children      = []
        @content_block = content_block
      end

      def layout(top, left, width, height)
        @engine.frame_context(self, top, left, width, height) do
          @content_block.call if @content_block
          left, top = 0, height
          layout_children(top, left, width, height) if @children.count
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

      def set_current_frame(frame)
        @engine.instance_eval { @current_frame = frame }
      end
    end

    class Engine
      def initialize(document, content_block)
        @document = document

        @current_frame = create_root_frame
        content_block.call(self)

        b = @document.bounds
        @current_frame.layout(b.top, b.left, b.width, b.height)
      end

      def frame(opts={}, &content_block)
        @current_frame.add_child(Frame.new(self, opts, content_block))
      end

      def frame_context(frame, top, left, width, height)
        @current_frame = frame
        @document.bounding_box([left, top], width: width, height: height) do
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