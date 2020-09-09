module Prawn
  module AutoLayout

    class FrameLayouter
      def initialize(document, &block)
        @document = document
        @contents = block
      end

      def layout(bounds)
        within_bounding_box(bounds) do
          do_layout(bounds)
        end
      end

      private

      def do_layout(bounds)
        @contents.call
      end

      def within_bounding_box(bounds, &block)
        @document.bounding_box(bounds.top_left, width: bounds.width, height: bounds.height, &block)
      end
    end

    class ContainerLayouter < FrameLayouter
      def initialize(document, &block)
        super(document, &block)
        @layouters = []
      end

      def columns(&block)
        @layouters << ColumnsLayouter.new(@document, &block)
      end

      def rows(&block)
        @layouters << RowsLayouter.new(@document, &block)
      end

      def frame(&block)
        @layouters << FrameLayouter.new(@document, &block)
      end

      private

      def do_layout(bounds)
        super(bounds)
        @layouters.each { |l| l.layout(bounds) }
      end
    end

    class ColumnsLayouter < ContainerLayouter

    end

    class RowsLayouter < ContainerLayouter

    end

    module Extensions
      def columns(&block)
        @current_layouter.columns(&block)
      end

      def rows(&block)
        @current_layouter.rows(&block)
      end

      def frame(&block)
        @current_layouter.frame(&block)
      end

      private

      def layout(bounds)
        @current_layouter.layout(bounds)
      end

      def init_layout(&block)
        @current_layouter = ContainerLayouter.new(self, &block)
      end
    end
  end

  class Document

    def self.generate_with_autolayout(filename, options={}, &block)
      generate(filename, options) do
        if block
          class << self
            include AutoLayout::Extensions
          end
          init_layout do
            block.arity < 1 ? instance_eval(&block) : block[self]
          end
          layout(bounds)
        end
      end
    end

    private

  end

end
