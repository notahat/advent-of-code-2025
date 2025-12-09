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

# Returns true if the ID is invalid (i.e. consists entirely of repeated
# substrings).
def invalid_id?(id)
  /^(.+)\1+$/ =~ id.to_s
end

result =
  ranges.flat_map { |range| range.select { |id| invalid_id?(id.to_s) } }.sum

puts result
