#!/usr/bin/env ruby

require_relative 'lib/prawn-boxes'

require 'prawn/measurement_extensions'

Prawn::Document.generate('boxtest.pdf') do
  managed_box do
    stroke_axis
  end
end

system 'open boxtest.pdf'