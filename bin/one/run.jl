using aoc2019

input = joinpath(@__DIR__, "input")
weights = aoc2019.fuel.read_weights(input)
p1 = aoc2019.fuel.calculate_fuel(weights)
@assert p1 == 3420719
p2 = aoc2019.fuel.calculate_fuel_v2(weights)
@assert p2 == 5128195
print("----------------------------------------------\n")
print("the tyranny of the rocket equation -- part one\n    fuel required : $p1\n")
print("the tyranny of the rocket equation -- part two\n    fuel required : $p2\n")
print("----------------------------------------------\n")
