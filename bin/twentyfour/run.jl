using Match
import Base.==

input = joinpath(@__DIR__, "input")
raw = readlines(input)

struct Coord
    x::Int
    y::Int
end

==(left::Coord, right::Coord) = left.x == right.x && left.y == right.y

struct Coord3
    x::Int
    y::Int
    z::Int
end

==(left::Coord3, right::Coord3) = left.x == right.x && left.y == right.y && left.z == right.z

function adjacent(coord::Coord)
    x, y = coord.x, coord.y
    return Set{Coord}([
        Coord(x, y + 1),
        Coord(x, y - 1),
        Coord(x + 1, y),
        Coord(x - 1, y)
    ])
end

function adjacent(coord::Coord3)
    x, y, z = coord.x, coord.y, coord.z
    adj = adjacent(Coord(x, y))
    acc = Set{Coord3}()
    for neighbor in adj
        res = @match (neighbor.x, neighbor.y, coord.x, coord.y) begin
            (3, 3, 2, 3) => [Coord3(1, i, z + 1) for i in 1:5]
            (3, 3, 4, 3) => [Coord3(5, i, z + 1) for i in 1:5]
            (3, 3, 3, 2) => [Coord3(i, 1, z + 1) for i in 1:5]
            (3, 3, 3, 4) => [Coord3(i, 5, z + 1) for i in 1:5]
            (0, _, _, _) => [Coord3(2, 3, z - 1)]
            (6, _, _, _) => [Coord3(4, 3, z - 1)]
            (_, 0, _, _) => [Coord3(3, 2, z - 1)]
            (_, 6, _, _) => [Coord3(3, 4, z - 1)]
            (_, _, _, _) => [Coord3(neighbor.x, neighbor.y, z)]
        end
        union!(acc, res)
    end
    return acc
end

function map_bugs(cs::Array{String,1})
    bugs = Set{Coord}()
    for j = 1:length(cs)
        line = cs[j]
        for i = 1:length(line)
            if line[i] == '#' push!(bugs, Coord(i, j)) end
        end
    end
    return bugs
end

function biod(bugs::Set{Coord})
    sum = 0
    for bug in bugs
        x, y = bug.x, bug.y
        pos = 5 * (y - 1) + x
        k = 2 ^ (pos - 1)
        sum += k
    end
    return sum
end

function mutate(bugs::Set{Coord})
    seen = Set{Int}()
    while true
        next = Set{Coord}()
        for i in 1:5
            for j in 1:5
                c = Coord(i, j)
                if c in bugs
                    adj = adjacent(c)
                    if length(intersect(adj, bugs)) == 1
                        push!(next, c)
                    end
                else
                    adj = adjacent(c)
                    if length(intersect(adj, bugs)) in 1:2
                        push!(next, c)
                    end
                end
            end
        end
        bugs = copy(next)
        if biod(next) in seen break end
        push!(seen, biod(next))
    end
    return bugs
end

function hypermutate(bugs::Set{Coord3})
    for iteration in 1:200
        next = Set{Coord3}()
        horizon = Set{Coord3}()
        for point in bugs
            union!(horizon, adjacent(point))
        end
        for c in horizon
            if c in bugs
                adj = adjacent(c)
                if length(intersect(adj, bugs)) == 1
                    push!(next, c)
                end
            else
                adj = adjacent(c)
                if length(intersect(adj, bugs)) in 1:2
                    push!(next, c)
                end
            end
        end
        bugs = copy(next)
    end
    return bugs
end

bugs = map_bugs(raw)

gen = mutate(copy(bugs))
p1 = biod(gen)
@assert p1 == 24662545


bugs = Set([Coord3(c.x, c.y, 0) for c in bugs])

gen = hypermutate(bugs)
p2 = length(gen)
@assert p2 == 2063

print("-----------------------------------------------------------------------\n")
print("planet of discord -- part one\n    biodiversity: $p1\n")
print("planet of discord -- part two\n    bugs        : $p2\n")
print("-----------------------------------------------------------------------\n")