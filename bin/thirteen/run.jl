using DelimitedFiles, Match
using aoc2019.computer

input = joinpath(@__DIR__, "input")
p = computer.load_program(input)

stdin, stdout = computer.io()
task = @async computer.run(copy(p), stdin, stdout)
while !istaskdone(task); yield(); end
close(stdout)

bits = [x for x in stdout]
screen = Dict{Pair, Int}()

while length(bits) > 0
    tile = pop!(bits)
    y = pop!(bits)
    x = pop!(bits)
    screen[Pair(x, y)] = tile
end

p1 = length(filter(x -> x == 2, collect(values(screen))))
@assert p1 == 335


stdin, stdout = computer.io()
program = copy(p)
## freeplay mode
program[1] = 2
task = @async computer.run(program, stdin, stdout)
sleep(1)

function play(task, stdin, stdout)
    screen = Dict{Pair, Int}()
    score = 0
    while true
        i = 1
        x, y, tile = nothing, nothing, nothing
        while isready(stdout)
            val = take!(stdout)
            @match mod(i, 1:3) begin
                1 => begin x = val end
                2 => begin y = val end
                3 => begin tile = val end
            end
            if x == -1 && y == 0 && tile !== nothing
                score = tile
                x, y, tile = nothing, nothing, nothing
            elseif x !== nothing && y !== nothing && tile !== nothing
                screen[Pair(x, y)] = tile
                x, y, tile = nothing, nothing, nothing
            end
            i += 1
        end
        ball = filter(bit -> bit.second == 4, screen)
        paddle = filter(bit -> bit.second == 3, screen)
        (bx, by) = first(collect(keys(ball)))
        (px, py) = first(collect(keys(paddle)))
        if bx > px
            put!(stdin, 1)
        elseif bx < px
            put!(stdin, -1)
        else
            put!(stdin, 0)
        end
        if istaskdone(task)
            break
        else
            yield()
        end
    end
    return score
end

p2 = play(task, stdin, stdout)
@assert p2 == 15706

print("-----------------------------------------------------------------------\n")
print("care package -- part one\n    total blocks : $p1\n")
print("care package -- part two\n    final score  : $p2\n")
print("-----------------------------------------------------------------------\n")