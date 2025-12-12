#!/usr/bin/env ruby

input = File.readlines("input.txt").map(&:split)

def solve(problem)
  *values, operation = problem
  values.map(&:to_i).reduce(operation)
end

result = input.transpose.map { solve(it) }.sum

puts result
