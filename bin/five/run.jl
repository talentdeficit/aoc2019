using aoc2019.computer: load_program, io, run

input = joinpath(@__DIR__, "input")
p = load_program(input)

stdin, stdout = io()
put!(stdin, 1)
run(copy(p), stdin, stdout)
close(stdout)
signals = [signal for signal in stdout]
p1 = last(signals)
@assert p1 == 6745903

stdin, stdout = io()
put!(stdin, 5)
run(copy(p), stdin, stdout)
close(stdout)
signals = [signal for signal in stdout]
p2 = last(signals)
@assert p2 == 9168267

print("-----------------------------------------------------------------------\n")
print("sunny with a chance of asteroids -- part one\n    final value : $p1\n")
print("sunny with a chance of asteroids -- part two\n    final value : $p2\n")
print("-----------------------------------------------------------------------\n")