using aoc2019.computer: load_program, run

input = joinpath(@__DIR__, "input")
p = load_program(input)

state = run(copy(p), [1])
p1 = first(state.outputs)
@assert p1 == 2350741403

state = run(copy(p), [2])
p2 = first(state.outputs)
@assert p2 == 53088

print("-----------------------------------------------------------------------\n")
print("sensor boost -- part one\n    boost keycode : $p1\n")
print("sensor boost -- part one\n    ceres coords  : $p2\n")
print("-----------------------------------------------------------------------\n")
