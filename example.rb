require 'prawn'
require_relative 'lib/prawn-autolayout'

Prawn::Document.generate_with_autolayout('example.pdf') do
  puts self
  columns do
    rows do
      frame do
        puts "frame"
        frame do
          puts "Boom"
        end
      end
      rows do
        puts "rows"
      end
    end
  end
end
