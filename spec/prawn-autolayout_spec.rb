require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Bounds', '#initialize' do
  it 'should initialize a Bounds instance' do
    b = Prawn::AutoLayout::Bounds.new(1, 2, 3, 4)
    b.top.should eq(1)
    b.left.should eq(2)
    b.width.should eq(3)
    b.height.should eq(4)
  end
end

describe 'Bounds', '#reset_origin' do
  it 'should return a new instance with the left coordinate set to 0 and the top coordinate set to the height' do
    b1 = Prawn::AutoLayout::Bounds.new(1, 2, 3, 4)
    b2 = b1.reset_origin
    b2.left.should eq(0)
    b2.top.should eq(4)
  end
end

describe 'Bounds', '#scale_width' do
  it 'should return a new instance with its width scaled by a factor' do
    b1 = Prawn::AutoLayout::Bounds.new(1, 2, 3, 4)
    b2 = b1.scale_width(0.5)
    b1.width.should eq(3)
    b2.width.should eq(1.5)
  end
end

describe 'Bounds', '#move_right' do
  it 'should return a new Bounds instance shifted right by its width' do
    b1 = Prawn::AutoLayout::Bounds.new(1, 2, 3, 4)
    b2 = b1.move_right
    b1.left.should eq(2)
    b2.left.should eq(5)
  end
end

describe 'Bounds', '#top_left' do
  it 'should return the top left point' do
    b = Prawn::AutoLayout::Bounds.new(1,2,3,4)
    b.top_left.should eq([2,1])
  end
end

describe 'Bound', '#move_down' do
  it 'should return a new Bounds instance shifted down by its height' do
    b1 = Prawn::AutoLayout::Bounds.new(10, 2, 3, 4)
    b2 = b1.move_down
    b1.top.should eq(10)
    b2.top.should eq(6)
  end
end

describe 'Bounds', '.from_document' do
  it 'should create an instance that according to the document''s bounds' do
    doc = mock_document(1, 2, 3, 4)
    b = Prawn::AutoLayout::Bounds.for_document(doc)
    b.top.should eq(1)
    b.left.should eq(2)
    b.width.should eq(3)
    b.height.should eq(4)
  end
end

describe 'Engine' do
  it 'should layout two frames evenly across the available width' do
    document = mock_document(100, 0, 100, 100)
    Prawn::AutoLayout::Engine.new(document) do

    end
  end
end
