using aoc2019.computer: load_program, io, run
using Match

input = joinpath(@__DIR__, "input")
p = load_program(input)

function camera!(channel, view)
    i, j = 0, 0
    for msg in channel
        if msg == 10
            i = 0
            j += 1
        else
            view[Pair(i, j)] = msg
            i += 1
        end
    end
end

function calibrate(view)
    scaffolds = collect(keys(filter(kv -> kv.second != 46, view)))
    acc = 0
    for kv in scaffolds
        x, y = kv
        up = Pair(x, y + 1)
        down = Pair(x, y - 1)
        right = Pair(x + 1, y)
        left = Pair(x - 1, y)
        if all(dir -> dir in scaffolds, [up, down, right, left])
            acc += x * y
        end
    end
    return acc
end

function display(view)
    i, j = 0, 0
    mx = maximum(map(kv -> kv.first, collect(keys(view))))
    my = maximum(map(kv -> kv.second, collect(keys(view))))
    for j in 0:my
        for i in 0:mx
            print(convert(Char, view[Pair(i,j)]))
            i += 1
        end
        println()
        i = 0
        j += 1
    end
end

function path(view)
    p = []
    robot = filter(kv -> kv.second != 46 && kv.second != 35, view)
    position, facing = first(robot)
    d = direction(facing)
    while true
        # must turn, try each and see if there's a scaffold in that direction
        rx, ry = turn_right(d)
        r = Pair(position.first + rx, position.second + ry)
        lx, ly = turn_left(d)
        l = Pair(position.first + lx, position.second + ly)
        if haskey(view, r) && view[r] != 46
            d = Pair(rx, ry)
            steps = 0
            while true
                next = Pair(position.first + d.first, position.second + d.second)
                if haskey(view, next) && view[next] != 46
                    steps += 1
                    position = next
                else
                    break
                end
            end
            push!(p, ("R", string(steps)))
        elseif haskey(view, l) && view[l] != 46
            d = Pair(lx, ly)
            steps = 0
            while true
                next = Pair(position.first + d.first, position.second + d.second)
                if haskey(view, next) && view[next] != 46
                    steps += 1
                    position = next
                else
                    break
                end
            end
            push!(p, ("L", string(steps)))
        else
            break
        end
    end
    return p
end

function turn_right(m)
    adj = Dict(
        Pair(0, 1) => Pair(-1, 0),
        Pair(1, 0) => Pair(0, 1),
        Pair(0, -1) => Pair(1, 0),
        Pair(-1, 0) => Pair(0, -1)
    )
    return adj[m]
end

function turn_left(m)
    adj = Dict(
        Pair(0, 1) => Pair(1, 0),
        Pair(1, 0) => Pair(0, -1),
        Pair(0, -1) => Pair(-1, 0),
        Pair(-1, 0) => Pair(0, 1)
    )
    return adj[m]
end

function direction(char)
    if char == convert(Int, '^')
        return Pair(0, -1)
    elseif char == convert(Int, '>')
        return Pair(1, 0)
    elseif char == convert(Int, 'v')
        return Pair(0, 1)
    elseif char == convert(Int, '<')
        return Pair(-1, 0)
    else
        throw("unreachable?")
    end
end

function send_input!(channel, instructions)
    reverse!(instructions)
    while true
        if isempty(instructions)
            put!(channel, 10)
            break
        else
            put!(channel, pop!(instructions))
        end
    end
end

function how_much_dust(channel)
    last = nothing
    while true
        v = take!(stdout)
        ## ignore ascii output
        if v < 128
            nothing
        else
            last = v
            break
        end
    end
    return last
end

stdin, stdout = io()
task = @async run(copy(p), stdin, stdout)

view = Dict{Pair{Int, Int}, Int}()

# let program run
while !istaskdone(task); yield() end
# close channel so it can be iterated over
close(stdout)
# populate view
camera!(stdout, view)
# display(view)

p1 = calibrate(view)
@assert p1 == 7280

# generate the path from start to end as turn-step pairs
# route = path(view)

## i compressed this by hand. no good ideas on how to do it progmatically
routine = map(c -> convert(Int, c), ['A', ',', 'B', ',', 'A', ',', 'C', ',', 'B', ',', 'C', ',', 'A', ',', 'B', ',', 'A', ',', 'C'])
a = map(c -> convert(Int, c), ['R', ',', '1', '0', ',', 'L', ',', '8', ',', 'R', ',', '1', '0', ',', 'R', ',', '4'])
b = map(c -> convert(Int, c), ['L', ',', '6', ',', 'L', ',', '6', ',', 'R', ',', '1', '0'])
c = map(c -> convert(Int, c), ['L', ',', '6', ',', 'R', ',', '1', '2', ',', 'R', ',', '1', '2', ',', 'R', ',', '1', '0'])

p[1] = 2
stdin, stdout = io()
task = @async run(copy(p), stdin, stdout)

send_input!(stdin, routine)
send_input!(stdin, a)
send_input!(stdin, b)
send_input!(stdin, c)
# no live output
send_input!(stdin, [convert(Int, 'n')])

# wait for program to run
while !istaskdone(task); yield() end
# close channel so we don't block
close(stdout)

p2 = how_much_dust(stdout)
@assert p2 == 1045393


print("-----------------------------------------------------------------------\n")
print("set and forget -- part one\n    calibration : $p1\n")
print("set and forget -- part two\n    dust        : $p2\n")
print("-----------------------------------------------------------------------\n")