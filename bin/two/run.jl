using aoc2019, DelimitedFiles

input = joinpath(@__DIR__, "input")
p = readdlm(input, ',', Int)

p1 = aoc2019.computer.run(copy(p))[1]
@assert p1 == 3101844

p2 = aoc2019.computer.nv(copy(p))
@assert p2 == 8478

print("------------------------------\n")
print("2012 program alarm -- part one\n    final value : $p1\n")
print("2012 program alarm -- part two\n    nounverb    : $p2\n")
print("------------------------------\n")