require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Bounds', '#initialize' do
  it "should initialize a Bounds instance" do
    b = Prawn::AutoLayout::Bounds.new(1, 2, 3, 4)
    b.width.should eq(3)
  end
end

describe 'AutoLayout' do
  it 'should layout two frames evenly across the available width' do
    false.should eq(true)
  end
end
