#!/usr/bin/env ruby

require 'prawn'
require 'prawn/measurement_extensions'
require_relative 'lib/prawn-autolayout'

Prawn::Document.generate('boxtest.pdf') do

  line_width 0.1.mm

  auto_layout do |layout|

    stroke_axis

    layout.frame do
      stroke_bounds
      layout.frame do
        stroke_bounds
      end
      layout.frame do
        stroke_bounds
      end
    end

    layout.frame do
      stroke_bounds
    end

    layout.frame do
      stroke_bounds
      layout.frame do
        stroke_bounds
        layout.frame do
          stroke_bounds
        end
        layout.frame do
          stroke_bounds
        end
      end
      layout.frame do
        stroke_bounds
      end
      layout.frame do
        stroke_bounds
      end
      layout.frame do
        stroke_bounds
        layout.frame do
          stroke_bounds
        end
        layout.frame do
          stroke_bounds
        end
        layout.frame do
          stroke_bounds
        end
        layout.frame do
          stroke_bounds
        end
      end
    end
  end
end

system 'open boxtest.pdf'