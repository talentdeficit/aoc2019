using LightGraphs
import Base.==

input = joinpath(@__DIR__, "input")
raw = readlines(input)

struct Coord
    x::Int
    y::Int
end

==(left::Coord, right::Coord) = left.x == right.x && left.y == right.y

function adjacent(coord::Coord)
    x, y = coord.x, coord.y
    return [
        Coord(x, y + 1),
        Coord(x, y - 1),
        Coord(x + 1, y),
        Coord(x - 1, y)
    ]
end

function map_maze!(cs::Array{String,1}, c2t::Dict{Coord,Char})
    for j = 1:length(cs)
        line = cs[j]
        for i = 1:length(line)
            t = line[i]
            c2t[Coord(i, j)] = t
        end
    end
end

function isalpha(char::Union{Char,Nothing})
    return char !== nothing && char >= 'A' && char <= 'Z'
end

function portals(c2t::Dict{Coord, Char})
    potentials = []
    for ct in c2t
        c, t = ct
        if t >= 'A' && t <= 'Z'
            push!(potentials, c)
        end
    end

    portals = Array{Pair{String, Coord}, 1}(undef, (0))
    for p in potentials
        x, y = p.x, p.y
        i = get(c2t, Coord(x - 1, y), nothing)
        j = c2t[p]
        k = get(c2t, Coord(x + 1, y), nothing)
        if i == '.' && isalpha(j)
            push!(portals, Pair(string(j, k), Coord(x - 1, y)))
        elseif isalpha(i) && k == '.'
            push!(portals, Pair(string(i, j), Coord(x + 1, y)))
        end
    end
    for p in potentials
        x, y = p.x, p.y
        i = get(c2t, Coord(x, y - 1), nothing)
        j = c2t[p]
        k = get(c2t, Coord(x, y + 1), nothing)
        if i == '.' && isalpha(j)
            push!(portals, Pair(string(j, k), Coord(x, y - 1)))
        elseif isalpha(i) && k == '.'
            push!(portals, Pair(string(i, j), Coord(x, y + 1)))
        end
    end
    return portals
end

function warp(coord, portals)
    label, _ = first(filter(kv -> kv.second.x == coord.x && kv.second.y == coord.y, portals))
    for w in filter(kv -> kv.first == label, portals)
        if w.second.x != coord.x && w.second.y != coord.y
            return w.second
        end
    end
end

function seen!(coord::Coord, level::Int, cache::Set{Pair{Coord, Int}})
    if Pair(coord, level) in cache
        return true
    else
        push!(cache, Pair(coord, level))
        return false
    end
end

function explore(start::Coord, finish::Coord, level::Int, c2t::Dict{Coord, Char}, portals::Array{Pair{String, Coord}, 1})
    nodes = [(start, 0, level)]
    seen = Set{Pair{Coord, Int}}()

    warps = [w.second for w in portals]
    xs = map(kv -> kv.second.x, portals)
    ys = map(kv -> kv.second.y, portals)
    minx = minimum(xs)
    maxx = maximum(xs)
    miny = minimum(ys)
    maxy = maximum(ys)

    while !isempty(nodes)
        node = popfirst!(nodes)
        coord, steps, level = node
        # skip exploring if we've already started from this node
        if seen!(coord, level, seen)
            continue
        else
            ## found exit, bail
            if coord == finish && level in [0, 1]
                return steps
            ## found exit but not at right level
            elseif coord == finish
                continue
            ## not a corridor
            elseif c2t[coord] != '.'
                continue
            elseif coord in warps && coord != start
                warp_to = warp(coord, portals)
                if (coord.x in [minx, maxx] || coord.y in [miny, maxy]) && level < 0
                    for neighbor in adjacent(warp_to)
                        push!(nodes, (neighbor, steps + 2, level + 1))
                    end
                elseif (coord.x in [minx, maxx] || coord.y in [miny, maxy]) && level == 0
                    continue
                elseif level <= 0
                    for neighbor in adjacent(warp_to)
                        push!(nodes, (neighbor, steps + 2, level - 1))
                    end
                else
                    for neighbor in adjacent(warp_to)
                        push!(nodes, (neighbor, steps + 2, level))
                    end
                end
            else
                for neighbor in adjacent(coord)
                    push!(nodes, (neighbor, steps + 1, level))
                end
            end
        end
    end
end

c2t = Dict{Coord,Char}()
map_maze!(raw, c2t)

ps = portals(c2t)

_, start = first(filter(n -> n.first == "AA", ps))
_, finish = first(filter(n -> n.first == "ZZ", ps))

p1 = explore(start, finish, 1, c2t, ps)
@assert p1 == 580

p2 = explore(start, finish, 0, c2t, ps)
@assert p2 == 6362

print("-----------------------------------------------------------------------\n")
print("donut maze -- part one\n    : $p1\n")
print("donut maze -- part two\n    : $p2\n")
print("-----------------------------------------------------------------------\n")