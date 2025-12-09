#!/usr/bin/env ruby

ranges =
  File
    .read("input.txt")
    .chop
    .split(",")
    .map do |range|
      first_id, last_id = range.split("-")
      (first_id.to_i..last_id.to_i)
    end

# Chop a string into an array of slices of the given length.
def slice_string(string, length)
  string.chars.each_slice(length).map(&:join)
end

# Returns true if the string consists entirely of repeated substrings of the
# given length.
def repeats?(string, length)
  slice_string(string, length).uniq.length == 1
end

# Returns true if the ID is invalid (i.e. consists entirely of repeated
# substrings).
def invalid_id?(id)
  id_string = id.to_s
  (1..id_string.length / 2).any? { |length| repeats?(id_string, length) }
end

result =
  ranges.flat_map { |range| range.select { |id| invalid_id?(id.to_s) } }.sum

puts result
