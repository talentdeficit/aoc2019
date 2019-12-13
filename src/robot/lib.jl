module robot

struct Point
    x::Int
    y::Int
end

const Black = 0
const White = 1
const Color = Int

const Counterclockwise = 0
const Clockwise = 1
const Rotation = Int

const Up = Point(0, 1)
const Down = Point(0, -1)
const Left = Point(-1, 0)
const Right = Point(1, 0)

mutable struct Robot
    orientation::Array{Point,1}
    location::Point
    surface::Dict{Point,Color}
end

function deploy(surface::Dict{Point,Color})
    return Robot([Up, Left, Down, Right], Point(0, 0), surface)
end

function deploy(surface::Dict{Point,Color}, point::Point)
    return Robot([Up, Left, Down, Right], point, surface)
end

function color(robot::Robot)
    ## anything unpainted is black
    return haskey(robot.surface, robot.location) ?
        robot.surface[robot.location] :
        Black
end

function paint!(robot::Robot, color::Color)
    robot.surface[robot.location] = color
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