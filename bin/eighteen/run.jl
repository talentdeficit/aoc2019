using LightGraphs

input = joinpath(@__DIR__, "input")
caverns = readlines(input)

struct Coord
    x::Int
    y::Int
end

function adjacent(coord::Coord)
    x, y = coord.x, coord.y
    return [
        Coord(x, y + 1),
        Coord(x, y - 1),
        Coord(x + 1, y),
        Coord(x - 1, y)
    ]
end

function map_caverns!(
    cs::Array{String,1},
    origins::Array{Int,1},
    c2v::Dict{Coord,Int},
    c2t::Dict{Coord,Char},
    v2c::Dict{Int,Coord},
    v2t::Dict{Int,Char}
)
    n = 1
    for j = 1:length(cs)
        line = cs[j]
        for i = 1:length(line)
            t = line[i]
            c2v[Coord(i, j)] = n
            c2t[Coord(i, j)] = t
            v2c[n] = Coord(i, j)
            v2t[n] = t
            ## capture any starting points
            if t == '@'
                push!(origins, n)
            end
            n += 1
        end
    end
    return n
end

function paths!(g::SimpleGraph{Int}, c2v::Dict{Coord,Int}, v2t::Dict{Int,Char})
    for loc in collect(keys(c2v))
        adj = adjacent(loc)
        for a in adj
            if haskey(c2v, a)
                src = c2v[loc]
                dst = c2v[a]
                if v2t[src] != '#' && v2t[dst] != '#'
                    add_edge!(g, src, dst)
                end
            end
        end
    end
end

function path_to_key!(cache::Dict{Pair{Int,Int},Array{Int,1}}, g::SimpleGraph{Int}, src::Int, dst::Int)
    k = Pair(src, dst)
    if haskey(cache, k)
        return cache[k]
    else
        path = map(e -> e.dst, a_star(g, src, dst))
        cache[k] = path
        return path
    end
end

function reachable(path::Array{Int,1}, have_keys::Set{Int}, v2t::Dict{Int,Char})
    target = v2t[last(path)]
    for v in path
        c = v2t[v]
        ## another key in path, don't bother exploring
        if c >= 'a' && c <= 'z' && c != target && !(v in have_keys)
            return false
        ## door in path, only continue if unlockable
        elseif c >= 'A' && c <= 'Z'
            ks = [uppercase(v2t[n]) for n in have_keys]
            if !(c in ks)
                return false
            end
        end
    end
    return true
end

function explore(g::SimpleGraph{Int}, origins::Array{Int,1}, v2t::Dict{Int,Char})
    nodes = [(Set{Int}(origins), 0, Set{Int}())]
    seen = Set{Tuple{Set{Int},Int,Set{Int}}}()

    ks = collect(keys(filter(vt -> vt.second >= 'a' && vt.second <= 'z', v2t)))

    # step count of shortest complete journey
    shortest_so_far = Inf

    # cache of paths
    cache = Dict{Pair{Int,Int},Array{Int,1}}()

    while !isempty(nodes)
        node = popfirst!(nodes)
        # skip exploring if we've already started from this node
        if node in seen
            continue
        else
            push!(seen, node)
            vertices, steps, have_keys = node
            ## have all keys, update `shortest_so_far` and stop exploring from
            ## here
            if length(have_keys) == length(ks)
                if steps < shortest_so_far
                    shortest_so_far = steps
                end
                continue
            end
            ## trip is longer than an already completed trip, don't explore
            ## further from here
            if steps > shortest_so_far
                continue
            end
            ## for each robot, create nodes for all possible moves
            for v in vertices
                for k in ks
                    if !(k in have_keys)
                        p = path_to_key!(cache, g, v, k)
                        if length(p) > 0 && reachable(p, have_keys, v2t)
                            new_vertices = copy(vertices)
                            delete!(new_vertices, v)
                            push!(new_vertices, k)
                            new_have_keys = copy(have_keys)
                            push!(new_have_keys, k)
                            new = (new_vertices, steps + length(p), new_have_keys)
                            if !(new in seen)
                                push!(nodes, new)
                            end
                        end
                    end
                end
            end
        end
    end

    return shortest_so_far
end

## starting point(s)
origins = Array{Int}(undef, (0))
## store coords to vertex id, coords to type, vertex id to coords and vertex id to type
c2v = Dict{Coord,Int}()
c2t = Dict{Coord,Char}()
v2c = Dict{Int,Coord}()
v2t = Dict{Int,Char}()
## vs is total number of nodes
vs = map_caverns!(caverns, origins, c2v, c2t, v2c, v2t)

g = SimpleGraph(vs)
paths!(g, c2v, v2t)

p1 = explore(g, origins, v2t)
# @assert p1 == 4762


## get old entrance coords
c = v2c[first(origins)]

## reset everything for p2

## store coords to vertex id, coords to type, vertex id to coords and vertex id to type
c2v = Dict{Coord,Int}()
c2t = Dict{Coord,Char}()
v2c = Dict{Int,Coord}()
v2t = Dict{Int,Char}()

## vs is total number of nodes
vs = map_caverns!(caverns, origins, c2v, c2t, v2c, v2t)

## mess with map for p2
v2t[c2v[c]] = '#'
for coord in adjacent(c)
    v = c2v[coord]
    v2t[v] = '#'
end
origins = Array{Int}(undef, (0))
for coord in [Coord(c.x + 1, c.y + 1), Coord(c.x + 1, c.y - 1), Coord(c.x - 1, c.y + 1), Coord(c.x - 1, c.y - 1)]
    v = c2v[coord]
    v2t[v] = '@'
    push!(origins, v)
end

h = SimpleGraph(vs)
paths!(h, c2v, v2t)

p2 = explore(h, origins, v2t)
@show p2
@assert p2 == 1876

print("-----------------------------------------------------------------------\n")
print("many worlds interpretation -- part one\n    distance : $p1\n")
print("many worlds interpretation -- part two\n    distance : $p2\n")
print("-----------------------------------------------------------------------\n")





