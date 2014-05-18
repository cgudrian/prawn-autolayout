#!/usr/bin/env ruby

require_relative 'lib/prawn-autolayout'

require 'prawn/measurement_extensions'

Prawn::Document.generate('boxtest.pdf') do
  auto_layout do |layout|

    stroke_axis

    layout.frame do
      stroke_bounds
    end

    layout.frame do
      stroke_bounds
    end

  end
end

system 'open boxtest.pdf'