require 'simplecov'

module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_profile 'test_frameworks'
end

ENV["COVERAGE"] && SimpleCov.start do
  add_filter "/.rvm/"
end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'prawn-autolayout'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end

def mock_document(left, top, width, height)
  doc = double('document')
  bounds = double('bounds')
  bounds.stub(:left).and_return(left)
  bounds.stub(:top).and_return(top)
  bounds.stub(:width).and_return(width)
  bounds.stub(:height).and_return(height)
  doc.stub(:bounds).and_return(bounds)
  doc
end