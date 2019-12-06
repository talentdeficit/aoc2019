using aoc2019, DelimitedFiles

input = joinpath(@__DIR__, "input")
orbits = readdlm(input, String)

p1 = aoc2019.star_chart.total_orbits(orbits)
@assert p1 == 301100

p2 = aoc2019.star_chart.total_transfers(orbits)
@assert p2 == 547

print("-------------------------------\n")
print("universal orbit map -- part one\n    total orbits    : $p1\n")
print("universal orbit map -- part two\n    total transfers : $p2\n")
print("-------------------------------\n")
