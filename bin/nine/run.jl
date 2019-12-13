using aoc2019.computer: load_program, io, run

input = joinpath(@__DIR__, "input")
p = load_program(input)

stdin, stdout = io()
put!(stdin, 1)
run(copy(p), stdin, stdout)
close(stdout)
signals = [signal for signal in stdout]
p1 = first(signals)
@assert p1 == 2350741403

stdin, stdout = io()
put!(stdin, 2)
run(copy(p), stdin, stdout)
close(stdout)
signals = [signal for signal in stdout]
p2 = first(signals)
@assert p2 == 53088

print("-----------------------------------------------------------------------\n")
print("sensor boost -- part one\n    boost keycode : $p1\n")
print("sensor boost -- part one\n    ceres coords  : $p2\n")
print("-----------------------------------------------------------------------\n")
