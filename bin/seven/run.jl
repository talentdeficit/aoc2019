using aoc2019.computer: load_program
using aoc2019.thrusters: output, feedback_loop
using Combinatorics

input = joinpath(@__DIR__, "input")
p = load_program(input)

perms = collect(permutations([4,3,2,1,0]))

p1 = maximum(asyncmap(perm -> output(copy(p), perm, 0), perms))
@assert p1 == 338603

perms = collect(permutations([9,8,7,6,5]))

p2 = maximum(asyncmap(perm -> feedback_loop(copy(p), perm, 0), perms))
@assert p2 == 63103596

print("-----------------------------------------------------------------------\n")
print("amplification circuit -- part one\n    max output : $p1\n")
print("amplification circuit -- part two\n    max output : $p2\n")
print("-----------------------------------------------------------------------\n")