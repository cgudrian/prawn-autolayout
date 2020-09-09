require 'spec_helper'

module Prawn
  module AutoLayout

    describe BaseLayouter do
      it 'should layout two frames evenly across the available width' do
        document = mock_document(0, 100, 100, 100)

        document.should_receive(:bounding_box).with([0, 100], { width: 100, height: 100 }).and_yield
        document.should_receive(:bounding_box).with([0, 100], { width: 50, height: 100 }).and_yield
        document.should_receive(:bounding_box).with([50, 100], { width: 50, height: 100 }).and_yield

        Prawn::AutoLayout::BaseLayouter.new(document) do |l|
          l.columns do
            l.frame do
            end
            l.frame do
            end
          end
        end
      end

      it 'should layout nested frames evenly across the available width' do
        document = mock_document(0, 100, 100, 100)

        document.should_receive(:bounding_box).with([0, 100], { width: 100, height: 100 }).and_yield

        document.should_receive(:bounding_box).with([0, 100], { width: 50, height: 100 }).and_yield
        document.should_receive(:bounding_box).with([0, 100], { width: 25, height: 100 }).and_yield
        document.should_receive(:bounding_box).with([25, 100], { width: 25, height: 100 }).and_yield

        document.should_receive(:bounding_box).with([50, 100], { width: 50, height: 100 }).and_yield
        document.should_receive(:bounding_box).with([0, 100], { width: 25, height: 100 }).and_yield
        document.should_receive(:bounding_box).with([25, 100], { width: 25, height: 100 }).and_yield

        BaseLayouter.new(document) do |l|
          l.columns do
            l.frame do
              l.frame do
              end
              l.frame do
              end
            end
            l.frame do
              l.frame do
              end
              l.frame do
              end
            end
          end
        end
      end
    end


  end
end
