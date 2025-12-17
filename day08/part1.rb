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

starting_circuits = Set.new(boxes.map { |box| Set.new([box]) })

pairs = boxes.combination(2).sort_by { |a, b| distance(a, b) }

final_circuits =
  pairs
    .take(1000)
    .reduce(starting_circuits) { |circuits, (a, b)| connect(circuits, a, b) }

puts final_circuits.map(&:size).sort.reverse.take(3).reduce(:*)
