#!/usr/bin/env ruby

input = File.readlines("input.txt").map(&:chomp)

class Warehouse
  def initialize(input)
    @cells = input.map { |row| row.chars.map { |c| c == "@" } }
    @width = @cells.first.length
    @height = @cells.length
  end

  # Iterate over all positions that have rolls.
  def each_roll
    each_position { |x, y| yield x, y if has_roll?(x, y) }
  end

  # Count the number of neighbouring rolls around position (x, y).
  def count_neighbours(x, y)
    neighbours(x, y).count { |nx, ny| has_roll?(nx, ny) }
  end

  private

  def has_roll?(x, y)
    (0...@width).include?(x) && (0...@height).include?(y) && @cells[y][x]
  end

  # Get the neighbouring positions around (x, y).
  def neighbours(x, y)
    (x - 1..x + 1)
      .flat_map do |nx|
        (y - 1..y + 1).map { |ny| [nx, ny] unless nx == x && ny == y }
      end
      .compact
  end

  # Iterate over all positions in the warehouse.
  def each_position
    (0...@height).each { |y| (0...@width).each { |x| yield x, y } }
  end
end

warehouse = Warehouse.new(input)

result =
  warehouse
    .to_enum(:each_roll)
    .map { |x, y| warehouse.count_neighbours(x, y) }
    .count { |neighbours| neighbours < 4 }

puts result
