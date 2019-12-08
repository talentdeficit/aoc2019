using aoc2019.wiring: manhattan_distance, signal_delay
using DelimitedFiles

input = joinpath(@__DIR__, "input")
ops = readdlm(input, String)

left = split(ops[1], ',')
right = split(ops[2], ',')

p1 = manhattan_distance(left, right)
@assert p1 == 1626

p2 = signal_delay(left, right)
@assert p2 == 27330

print("-----------------------------------------------------------------------\n")
print("crossed wires -- part one\n    distance : $p1\n")
print("crossed wires -- part two\n    delay    : $p2\n")
print("-----------------------------------------------------------------------\n")