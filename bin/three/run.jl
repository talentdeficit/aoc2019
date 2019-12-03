using aoc2019, DelimitedFiles

input = joinpath(@__DIR__, "input")
ops = vec(readdlm(input, String))
left = split(ops[1], ',')
right = split(ops[2], ',')
p1 = aoc2019.three.manhattan_distance(left, right)
p2 = aoc2019.three.signal_delay(left, right)
print("-------------------------\n")
print("crossed wires -- part one\n    distance : $p1\n")
print("crossed wires -- part two\n    delay    : $p2\n")
print("-------------------------\n")