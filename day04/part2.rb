#!/usr/bin/env ruby

input = File.readlines("input.txt").map(&:chomp)

class Warehouse
  def initialize(cells)
    @cells = cells
    @width = @cells.first.length
    @height = @cells.length
  end

  # Create a Warehouse from input strings.
  def self.from_input(input)
    cells = input.map { |row| row.chars.map { |c| c == "@" } }
    new(cells)
  end

  # Recursively remove rolls that have less than 4 neighbours, and return the
  # total number of rolls removed.
  def recursively_remove_rolls
    return 0 if removable_rolls.empty?

    removable_rolls.count + with_rolls_removed.recursively_remove_rolls
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

  # Count the number of neighbouring rolls around position (x, y).
  def count_neighbours(x, y)
    neighbours(x, y).count { |nx, ny| has_roll?(nx, ny) }
  end

  # Iterate over all positions in the warehouse.
  def each_position
    (0...@height).each { |y| (0...@width).each { |x| yield x, y } }
  end

  # Iterate over all positions that have rolls.
  def each_roll
    each_position { |x, y| yield x, y if has_roll?(x, y) }
  end

  # Get the (x, y) location of all rolls that can be removed (less than 4 neighbours).
  def removable_rolls
    @removable_rolls ||=
      to_enum(:each_roll).select { |x, y| count_neighbours(x, y) < 4 }
  end

  # Create a new Warehouse with specified rolls removed.
  def with_rolls_removed
    cells = @cells.map(&:dup)
    removable_rolls.each { |x, y| cells[y][x] = false }
    Warehouse.new(cells)
  end
end

warehouse = Warehouse.from_input(input)

puts warehouse.recursively_remove_rolls
