#!/usr/bin/env ruby

input = File.readlines("input.txt").map(&:chomp)

fresh_id_ranges_input, _ = input.slice_before(&:empty?).to_a

# Parse the ranges from the input.
fresh_id_ranges =
  fresh_id_ranges_input.map do |range|
    start_id, end_id = range.split("-").map(&:to_i)
    (start_id..end_id)
  end

# Take a list of ranges and merge any that overlap.
def merge_ranges(ranges)
  ranges
    .sort_by(&:min)
    .chunk_while { |a, b| a.overlap?(b) }
    .map { |chunk| (chunk.first.min..chunk.map(&:max).max) }
end

result = merge_ranges(fresh_id_ranges).sum(&:size)

puts result
