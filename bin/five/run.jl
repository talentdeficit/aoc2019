using aoc2019

input = joinpath(@__DIR__, "input")
p = aoc2019.computer.load_program(input)

(_, output) = aoc2019.computer.run(copy(p), [1])
p1 = output
@assert p1 == 6745903

(_, output) = aoc2019.computer.run(copy(p), [5])
p2 = output
@assert p2 == 9168267

print("-----------------------------------------------------------------------\n")
print("sunny with a chance of asteroids -- part one\n    final value : $p1\n")
print("sunny with a chance of asteroids -- part two\n    final value : $p2\n")
print("-----------------------------------------------------------------------\n")