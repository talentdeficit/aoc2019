using aoc2019.computer: load_program, io, run
using Match, LightGraphs

input = joinpath(@__DIR__, "input")
p = load_program(input)

struct Coord
    x::Int
    y::Int
end

mutable struct Maze
    pathing::SimpleDiGraph
    origin::Union{Coord, Nothing}
    oxygen::Union{Coord, Nothing}
    corridors::Set{Int}
    walls::Set{Int}
    ## ordered so recently discovered unknowns are visited first
    unknown::Array{Int, 1}
    vertices::Dict{Coord, Int}
end

NORTH = 1
SOUTH = 2
WEST = 3
EAST = 4

WALL = 0
OK = 1
OXY = 2
UNKNOWN = 3

function explore!(location, maze, stdin, stdout)
    loc = location
    while true
        ## add current location and neighbors to the maze
        update_maze!(maze, loc, OK)
        ## stop when there are no remaining unknown nodes
        if length(maze.unknown) == 0
            break
        end
        ## find the most recently discovered unknown location
        nearest_unknown = last(maze.unknown)
        edge = first(a_star(maze.pathing, maze.vertices[loc], nearest_unknown))
        next = first(collect(keys(filter(n -> n.second == edge.dst, maze.vertices))))
        ## try to move closer to nearest_unknown
        put!(stdin, dir(loc, next))
        res = take!(stdout)
        @match res begin
            0 => begin
                ## wall, move vertex from unknown to wall and loop
                t!(maze, edge.dst, WALL)
            end
            1 => begin
                ## corridor, move to location and loop
                loc = next
            end
            2 => begin
                ## oxygen!! move to location and update maze
                t!(maze, edge.dst, OXY)
                maze.oxygen = next
                loc = next
            end
        end
    end
end

function update_maze!(maze, location, t)
    # add or update vertex and return vertex id
    id = add_or_update_vertex!(maze, location, OK)
    # update neighbors
    for direction in [NORTH, SOUTH, WEST, EAST]
        destination = coords(direction, location)
        if !exists(maze, destination)
            # add unvisited neighbor to the maze as unknown
            add_or_update_vertex!(maze, destination, UNKNOWN)
        end
        # add edge from location to neighbor if none exists
        nid = maze.vertices[destination]
        if !has_edge(maze.pathing, id, nid)
            add_edge!(maze.pathing, id, nid)
        end
    end
end

function add_or_update_vertex!(maze, location, t)
    if !exists(maze, location)
        add_vertex!(maze.pathing)
        id = nv(maze.pathing)
        maze.vertices[location] = id
        t!(maze, id, t)
        return id
    else
        id = maze.vertices[location]
        t!(maze, id, t)
        return id
    end
end

function exists(maze, location)
    return haskey(maze.vertices, location) ? true : false
end

function t!(maze, id, t)
    @match t begin
        0 => begin
            push!(maze.walls, id)
            filter!(n -> n != id, maze.unknown)
        end
        1 => begin
            push!(maze.corridors, id)
            filter!(n -> n != id, maze.unknown)
        end
        2 => begin
            ## mark oxygen as a corridor so it's navigable
            push!(maze.corridors, id)
            filter!(n -> n != id, maze.unknown)
        end
        3 => begin
            push!(maze.unknown, id)
        end
    end
end

function coords(dir::Int, location::Coord)
    x, y = location.x, location.y
    @match dir begin
        1 => return Coord(x, y + 1)
        2 => return Coord(x, y - 1)
        3 => return Coord(x + 1, y)
        4 => return Coord(x - 1, y)
        _ => throw("unreachable")
    end
end

function dir(location::Coord, destination::Coord)
    x, y = location.x, location.y
    dx, dy = destination.x, destination.y
    @match Pair(dx - x, dy - y) begin
        Pair(0, 1) => return NORTH
        Pair(0, -1) => return SOUTH
        Pair(-1, 0) => return WEST
        Pair(1, 0) => return EAST
        _ => throw("unreachable")
    end
end

## robot location, also the origin
location = Coord(0, 0)
## the maze
maze = Maze(
    SimpleDiGraph(),
    location,
    nothing,
    Set{Int}(),
    Set{Int}(),
    Array{Int, 1}(),
    Dict{Coord, Int}()
)

# start computer
stdin, stdout = io()
@async run(copy(p), stdin, stdout)

explore!(location, maze, stdin, stdout)

pathing = maze.pathing
vertices = maze.vertices
origin = vertices[maze.origin]
oxygen = vertices[maze.oxygen]

p1 = length(a_star(pathing, origin, oxygen))
@assert p1 == 236

corridors = collect(maze.corridors)
p2 = maximum(map(v -> length(a_star(pathing, oxygen, v)), corridors))
@assert p2 == 368


print("-----------------------------------------------------------------------\n")
print("oxygen system -- part one\n    distance to leak           : $p1\n")
print("oxygen system -- part two\n    distance to furthest point : $p2\n")
print("-----------------------------------------------------------------------\n")