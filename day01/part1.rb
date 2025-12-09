#!/usr/bin/env ruby

rotations = File.readlines("input.txt").map(&:chomp)

def parse_rotation(input)
  direction = input[0]
  distance = input[1..-1].to_i
  [direction, distance]
end

def rotate(position, rotation)
  direction, distance = parse_rotation(rotation)
  case direction
  when "L"
    (position - distance) % 100
  when "R"
    (position + distance) % 100
  end
end

result =
  rotations
    .reduce([50]) do |positions, rotation|
      [*positions, rotate(positions.last, rotation)]
    end
    .count(&:zero?)

puts result
