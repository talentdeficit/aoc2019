using aoc2019.Fuel: total, correct_total
using DelimitedFiles

input = joinpath(@__DIR__, "input")
weights = readdlm(input, Int)

p1 = total(weights)
@assert p1 == 3420719

p2 = correct_total(weights)
@assert p2 == 5128195

print("-----------------------------------------------------------------------\n")
print("the tyranny of the rocket equation -- part one\n    fuel required : $p1\n")
print("the tyranny of the rocket equation -- part two\n    fuel required : $p2\n")
print("-----------------------------------------------------------------------\n")
