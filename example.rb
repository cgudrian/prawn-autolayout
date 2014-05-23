require 'prawn'
require_relative 'lib/prawn-autolayout'

Prawn::Document.generate('example.pdf') do
  columns do
    rows do
      frame do
        puts "frame"
      end
      rows do
        puts "rows"
      end
    end
  end
end
