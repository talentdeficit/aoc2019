using aoc2019

input = joinpath(@__DIR__, "input")
p = aoc2019.two.read_program(input)
p1 = aoc2019.two.run(copy(p))[1]
p2 = aoc2019.two.nv(copy(p))
print("------------------------------\n")
print("2012 program alarm -- part one\n    final value : $p1\n")
print("2012 program alarm -- part two\n    nounverb    : $p2\n")
print("------------------------------\n")