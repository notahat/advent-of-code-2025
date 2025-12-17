#!/usr/bin/env ruby

instructions = File.readlines("input.txt").map(&:strip)

def offsets_of_chars(input, char)
  input.chars.each_with_index.find_all { |c, _i| c == char }.map { |_c, i| i }
end

starting_line, *splitter_lines = instructions

starting_beams = offsets_of_chars(starting_line, "S")
splitters =
  splitter_lines.map { |line| offsets_of_chars(line, "^") }.reject(&:empty?)

def split_beams(beams, splitter_positions)
  beams
    .flat_map do |beam_position|
      if splitter_positions.include?(beam_position)
        [beam_position - 1, beam_position + 1]
      else
        beam_position
      end
    end
    .uniq
end

State = Struct.new(:beams, :split_count)

final_beams =
  splitters.reduce(State.new(starting_beams, 0)) do |state, splitter_positions|
    new_beams = split_beams(state.beams, splitter_positions)
    new_splits = state.beams.intersection(splitter_positions).size
    State.new(new_beams, state.split_count + new_splits)
  end

puts final_beams.split_count
