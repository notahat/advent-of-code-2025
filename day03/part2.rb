#!/usr/bin/env ruby

battery_banks =
  File.readlines("input.txt").map(&:chomp).map { |bank| bank.chars.map(&:to_i) }

def max_joltage(bank, length)
  return 0 if length == 0

  value, index =
    bank[0..-length].each_with_index.max_by { |value, index| value }

  value * (10**length) + max_joltage(bank[index + 1..-1], length - 1)
end

result = battery_banks.map { |bank| max_joltage(bank, 12) }.sum

puts result
