#!/usr/bin/env ruby

input = %W[3-5 10-14 16-20 12-18 #{""} 1 5 8 11 17 32]

input = File.readlines("input.txt").map(&:chomp)

fresh_id_ranges_input, available_ids_input = input.slice_before(&:empty?).to_a

# Parse the ranges from the input.
fresh_id_ranges =
  fresh_id_ranges_input.map do |range|
    start_id, end_id = range.split("-").map(&:to_i)
    (start_id..end_id)
  end

# Parse the available IDs from the input.
available_ids = available_ids_input.drop(1).map(&:to_i)

result =
  available_ids.count do |id|
    fresh_id_ranges.any? { |range| range.include?(id) }
  end

puts result
