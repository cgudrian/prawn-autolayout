require_relative 'frame'

module Prawn
  module AutoLayout
    class Engine
      def initialize(document, &content_block)
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

      def columns
        yield
      end

      private

      def create_root_frame
        Frame.new(self, {}, nil)
      end
    end
  end
end