module Prawn
  module AutoLayout
    class Frame
      def initialize(engine, opts, content_block)
        @engine        = engine
        @layouters      = []
        @content_block = content_block
      end

      def layout(bounds)
        @engine.frame_context(self, bounds) do
          @content_block.call if @content_block
          layout_children(bounds.reset_origin) if @layouters.count
        end
      end

      def add_child(frame)
        @layouters << frame
      end

      def layout_children(bounds)
        bounds = bounds.scale_width(1.0 / @layouters.count)
        @layouters.each do |c|
          c.layout(bounds)
          bounds = bounds.move_right
        end
      end
    end
  end
end