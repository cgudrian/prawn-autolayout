require 'spec_helper'

module Prawn
  module AutoLayout
    describe Bounds do

      before(:each) do
        @sut = Bounds.new(1, 2, 3, 4)
      end

      describe '#initialize' do
        it 'should initialize a Bounds instance' do
          @sut.left.should eq(1)
          @sut.top.should eq(2)
          @sut.width.should eq(3)
          @sut.height.should eq(4)
        end
      end

      describe '#reset_origin' do
        it 'should return a new instance with the left coordinate set to 0 and the top coordinate set to the height' do
          b = @sut.reset_origin
          @sut.left.should eq(1)
          b.left.should eq(0)
          b.top.should eq(4)
        end
      end

      describe '#scale_width' do
        it 'should return a new instance with its width scaled by a factor' do
          b = @sut.scale_width(0.5)
          @sut.width.should eq(3)
          b.width.should eq(1.5)
        end
      end

      describe '#move_right' do
        it 'should return a new Bounds instance shifted right by its width' do
          b = @sut.move_right
          @sut.left.should eq(1)
          b.left.should eq(4)
        end
      end

      describe '#top_left' do
        it 'should return the top left point' do
          @sut.top_left.should eq([1, 2])
        end
      end

      describe '#move_down' do
        it 'should return a new Bounds instance shifted down by its height' do
          b1 = Bounds.new(2, 10, 3, 4)
          b2 = b1.move_down
          b1.top.should eq(10)
          b2.top.should eq(6)
        end
      end

      describe '.from_document' do
        it "should create an instance according to the document's bounds" do
          doc = mock_document(1, 2, 3, 4)
          b   = Bounds.for_document(doc)
          b.left.should eq(1)
          b.top.should eq(2)
          b.width.should eq(3)
          b.height.should eq(4)
        end
      end
    end
  end
end