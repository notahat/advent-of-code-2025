#!/usr/bin/env ruby

input = File.read("input.txt").split("\n")

Point = Struct.new(:x, :y, :z)

def distance(a, b)
  Math.sqrt((a.x - b.x)**2 + (a.y - b.y)**2 + (a.z - b.z)**2)
end

boxes = input.map { |line| Point.new(*line.split(",").map(&:to_f)) }

def connect(circuits, box_a, box_b)
  circuit_a = circuits.find { it.include?(box_a) }
  circuit_b = circuits.find { it.include?(box_b) }

  if circuit_a != circuit_b
    circuits - [circuit_a, circuit_b] + [(circuit_a | circuit_b)]
  else
    circuits
  end
end

pairs = boxes.combination(2).sort_by { |a, b| distance(a, b) }

circuits = Set.new(boxes.map { |box| Set.new([box]) })

# This represents a connection we've added between a pair of boxes, and the
# resulting set of circuits.
Connection = Struct.new(:pair, :circuits)

last_connection =
  pairs
    .lazy
    .map do |a, b|
      # I really don't like having mutable state in a lazy map like this, but I
      # haven't figured out a neater way. 🤔
      circuits = connect(circuits, a, b)
      Connection.new([a, b], circuits)
    end
    .drop_while { |connection| connection.circuits.size > 1 }
    .first

a, b = *last_connection.pair
puts (a.x * b.x).to_i
