using aoc2019.asteroids
using DelimitedFiles

input = joinpath(@__DIR__, "input")
map = readdlm(input, String)

coords = asteroids.chart(map)

(origin, p1) = maxima(coords)
@assert p1 == 274

destroyed = asteroids.sweep(coords, origin, atan(-1, 0) + asteroids.tau, atan(-1, 0))
winner = destroyed[200]
p2 = ((winner.x - 1) * 100) + (winner.y - 1)
@assert p2 == 305

print("-----------------------------------------------------------------------\n")
print("monitoring station -- part one\n    observed : $p1\n")
print("monitoring station -- part two\n    destroyed: $p2\n")
print("-----------------------------------------------------------------------\n")