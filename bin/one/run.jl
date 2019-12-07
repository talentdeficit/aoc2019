using aoc2019, DelimitedFiles

input = joinpath(@__DIR__, "input")
weights = readdlm(input, Int)

p1 = aoc2019.fuel.total(weights)
@assert p1 == 3420719

p2 = aoc2019.fuel.correct_total(weights)
@assert p2 == 5128195

print("-----------------------------------------------------------------------\n")
print("the tyranny of the rocket equation -- part one\n    fuel required : $p1\n")
print("the tyranny of the rocket equation -- part two\n    fuel required : $p2\n")
print("-----------------------------------------------------------------------\n")
