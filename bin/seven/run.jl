using aoc2019, Combinatorics

input = joinpath(@__DIR__, "input")
p = aoc2019.computer.load_program(input)

perms = collect(permutations([4,3,2,1,0]))

p1 = maximum([aoc2019.thrusters.output(copy(p), perm, 0) for perm in perms])
@assert p1 == 338603

perms = collect(permutations([9,8,7,6,5]))

p2 = maximum([aoc2019.thrusters.feedback_loop(copy(p), perm, 0) for perm in perms])
@assert p2 == 63103596

print("-----------------------------------------------------------------------\n")
print("amplification circuit -- part one\n    max output : $p1\n")
print("amplification circuit -- part two\n    max output : $p2\n")
print("-----------------------------------------------------------------------\n")