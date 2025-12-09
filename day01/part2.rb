#!/usr/bin/env ruby

rotations = File.readlines("input.txt").map(&:chomp)

def parse_rotation(input)
  direction = input[0]
  distance = input[1..-1].to_i
  [direction, distance]
end

Result =
  Struct.new(
    :position, # The position the dial finishes in after a rotation
    :zero_count # How many times it passed through zero on that rotation
  )

def rotate(position, rotation)
  direction, distance = parse_rotation(rotation)

  new_position =
    case direction
    when "L"
      position - distance
    when "R"
      position + distance
    end

  movement_range =
    case direction
    when "L"
      (new_position..position - 1)
    when "R"
      (position + 1..new_position)
    end
  zero_count = movement_range.count { |position| position % 100 == 0 }

  Result.new(new_position % 100, zero_count)
end

result =
  rotations
    .reduce([Result.new(50, 0)]) do |results, rotation|
      [*results, rotate(results.last.position, rotation)]
    end
    .sum(&:zero_count)

puts result
