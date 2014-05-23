require_relative 'prawn-autolayout/frame.rb'
require_relative 'prawn-autolayout/bounds.rb'
require_relative 'prawn-autolayout/layouter.rb'

class Frame
  def initialize(bounds, &block)
    @bounds = bounds
    @contents = block
  end
end

class Container < Frame
  def initialize(bounds, &block)
    super(bounds, &block)
    @children = []
  end

  def columns
    @children << Container.new(@bounds, &block)
  end

  def rows
    @children << Container.new(@bounds, &block)
  end

  def frame
    @children << Frame.new(@bounds, &block)
  end
end

module Prawn
  class Document
    def auto_layout(&content_block)
      AutoLayout::Layouter.new(self, &content_block)
    end

    def columns(&block)
      current_frame.columns do |c|
        within_frame(c, &block)
      end
    end

    def rows(&block)
      current_frame.rows do |c|
        within_frame(c, &block)
      end
    end

    def frame(&block)
      current_frame.frame do |c|
        within_frame(c, &block)
      end
    end

    private

    def current_frame
      @frame ||= Container.new(bounds)
    end

    def within_frame(new_frame)
      old_frame, @frame = @frame, new_frame
      yield
    ensure
      @frame = old_frame
    end
  end
end
