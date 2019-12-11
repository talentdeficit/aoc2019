module hull

struct Point
    x::Int
    y::Int
end

const Black = 0
const White = 1
const Color = Union{Int, Int}

const Counterclockwise = 0
const Clockwise = 1
const Rotation = Union{Int, Int}

const Up = Point(0, 1)
const Down = Point(0, -1)
const Left = Point(-1, 0)
const Right = Point(1, 0)

mutable struct Robot
    orientation::Array{Point,1}
    location::Point
end

function deploy()
    return Robot([Up, Left, Down, Right], Point(0, 0))
end

function color(hull::Dict{Point, Color}, location::Point)
    ## anything unpainted is black
    return haskey(hull, location) ? hull[location] : Black
end

function paint!(hull::Dict{Point, Color}, loc::Point, color::Color)
    hull[loc] = color
end

function move!(robot::Robot, rotation::Rotation)
    if rotation == Counterclockwise
        reverse!(robot.orientation)
        prepend!(robot.orientation, [pop!(robot.orientation)])
        reverse!(robot.orientation)
    else
        prepend!(robot.orientation, [pop!(robot.orientation)])
    end
    orientation = first(robot.orientation)
    robot.location = Point(robot.location.x + orientation.x, robot.location.y + orientation.y)
    l = robot.location
end

end