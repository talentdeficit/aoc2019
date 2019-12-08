using aoc2019.star_chart: total_orbits, total_transfers
using DelimitedFiles

input = joinpath(@__DIR__, "input")
orbits = readdlm(input, String)

p1 = total_orbits(orbits)
@assert p1 == 301100

p2 = total_transfers(orbits)
@assert p2 == 547

print("-----------------------------------------------------------------------\n")
print("universal orbit map -- part one\n    total orbits    : $p1\n")
print("universal orbit map -- part two\n    total transfers : $p2\n")
print("-----------------------------------------------------------------------\n")
