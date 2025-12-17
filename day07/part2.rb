#!/usr/bin/env ruby

instructions = File.readlines("input.txt").map(&:strip)

def offsets_of_chars(input, char)
  input.chars.each_with_index.find_all { |c, _i| c == char }.map { |_c, i| i }
end

starting_line, *splitter_lines = instructions

# Figure out the positions of the staring beams and splitters from the input.
starting_beams = offsets_of_chars(starting_line, "S")
splitters =
  splitter_lines.map { |line| offsets_of_chars(line, "^") }.reject(&:empty?)

# The idea is to work down the qunatum tachyon manifold, keeping track of how
# many different paths have led to each beam position.
#
# We store this as a hash of path counts, mapping beam positions to the counts.
#
# This method takes the current path counts and an array of splitter positions,
# and returns new path counts after the beams have passed through the splitters.
def split_beams(path_counts, splitter_positions)
  path_counts
    .each_pair
    .reduce(Hash.new(0)) do |new_path_counts, (position, count)|
      if splitter_positions.include?(position)
        new_path_counts[position - 1] += count
        new_path_counts[position + 1] += count
      else
        new_path_counts[position] += count
      end
      new_path_counts
    end
end

starting_path_counts =
  starting_beams.reduce(Hash.new(0)) do |path_counts, position|
    path_counts[position] = 1
    path_counts
  end

final_path_counts =
  splitters.reduce(starting_path_counts) do |path_counts, splitter_positions|
    split_beams(path_counts, splitter_positions)
  end

puts final_path_counts.values.sum
