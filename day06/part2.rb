#!/usr/bin/env ruby

input = File.readlines("input.txt").map(&:chomp)

# Pad out all the value lines to the same length, so the vertical columns align
# correctly in the rightmost problem.
max_line_length = input.map(&:length).max
input = input.map { |line| line.ljust(max_line_length) }

# Separate the values from the operations.
*value_lines, operations_line = input

# We read values down the columns, so flip the rows and columns.
flipped_values = value_lines.map(&:chars).transpose.map(&:join).map(&:strip)

# Group the values together by problem.
problem_values =
  flipped_values
    .slice_after(&:empty?)
    .map { |problem| problem.reject(&:empty?) }

# Extract the operation for each problem.
operations = operations_line.chars.find_all { it != " " }

def solve(operation, values)
  values.map(&:to_i).reduce(operation)
end

# Solve each problem and sum the results.
result =
  operations
    .zip(problem_values)
    .map { |operation, values| solve(operation, values) }
    .sum

puts result
