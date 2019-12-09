using aoc2019.computer: load_program, run

input = joinpath(@__DIR__, "input")
p = load_program(input)

state = run(copy(p), [1])
p1 = first(state.outputs)
@assert p1 == 6745903

state = run(copy(p), [5])
p2 = first(state.outputs)
@assert p2 == 9168267

print("-----------------------------------------------------------------------\n")
print("sunny with a chance of asteroids -- part one\n    final value : $p1\n")
print("sunny with a chance of asteroids -- part two\n    final value : $p2\n")
print("-----------------------------------------------------------------------\n")