#!/usr/bin/env ruby

battery_banks =
  File.readlines("input.txt").map(&:chomp).map { |bank| bank.chars.map(&:to_i) }

def max_joltage(bank)
  first_value, first_index =
    bank[0..-2].each_with_index.max_by { |value, index| value }
  second_value = bank[first_index + 1..-1].max
  first_value * 10 + second_value
end

result = battery_banks.map { |bank| max_joltage(bank) }.sum

puts result
