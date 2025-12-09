#!/usr/bin/env ruby

ranges =
  File
    .read("input.txt")
    .chomp
    .split(",")
    .map do |range|
      first_id, last_id = range.split("-")
      (first_id.to_i..last_id.to_i)
    end

def invalid_id?(id)
  id_string = id.to_s
  return if id_string.length.odd?

  half_length = id_string.length / 2
  first_half = id_string[0...half_length]
  second_half = id_string[half_length..-1]
  first_half == second_half
end

result =
  ranges.flat_map { |range| range.select { |id| invalid_id?(id.to_s) } }.sum

puts result
