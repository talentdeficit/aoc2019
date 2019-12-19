using aoc2019.computer: load_program, io, run
using Match

input = joinpath(@__DIR__, "input")
p = load_program(input)

affected = 0

function scan(i, j)
    stdin, stdout = io()
    @async run(copy(p), stdin, stdout)
    put!(stdin, i)
    put!(stdin, j)
    res = take!(stdout)
    close(stdin)
    close(stdout)
    return res == 1 ? true : false
end

for i in 0:49
    for j in 0:49
        if scan(i, j)
            global affected += 1
        end
    end
end

i = 0
j = 99
n = nothing

while true
    # scan until beam found
    while !scan(i, j)
        global i += 1
    end
    # check box
    if scan(i + 99, j - 99)
        global n = i * 10000 + j - 99
        break
    end
    global j += 1
end

p1 = affected
@assert p1 == 206
p2 = n
@assert p2 == 6190948


print("-----------------------------------------------------------------------\n")
print("tractor beam -- part one\n    affected : $p1\n")
print("tractor beam -- part two\n    distance : $p2\n")
print("-----------------------------------------------------------------------\n")

