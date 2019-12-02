using aoc2019

input = joinpath(@__DIR__, "input")
weights = aoc2019.one.read_weights(input)
p1 = aoc2019.one.calculate_fuel(weights)
p2 = aoc2019.one.calculate_total_fuel(weights)
print("----------------------------------------------\n")
print("the tyranny of the rocket equation -- part one\n    fuel required : $p1\n")
print("the tyranny of the rocket equation -- part two\n    fuel required : $p2\n")
print("----------------------------------------------\n")
