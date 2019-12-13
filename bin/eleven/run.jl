using aoc2019.computer: load_program, io, run
using aoc2019.robot: Point, Black, White, deploy, color, paint!, move!
using Match

input = joinpath(@__DIR__, "input")
p = load_program(input)

function activate_robot(program, initial_color)
    surface = Dict{Point, Int}()
    robot = deploy(surface)
    paint!(robot, initial_color)
    stdin, stdout = io()
    task = @async run(p, stdin, stdout)
    while !istaskdone(task)
        put!(stdin, color(robot))
        current_color = take!(stdout)
        turn = take!(stdout)
        paint!(robot, current_color)
        move!(robot, turn)
        yield()
    end
    return surface
end

ship = activate_robot(copy(p), Black)
p1 = length(collect(keys(ship)))
@assert p1 == 1951

ship = activate_robot(copy(p), White)
p2 = length(collect(keys(ship)))
@assert p2 == 249

xmin = minimum([p.x for p in collect(keys(ship))])
ymin = minimum([p.y for p in collect(keys(ship))])
xmax = maximum([p.x + abs(xmin) + 1 for p in collect(keys(ship))])
ymax = maximum([p.y + abs(ymin) + 1 for p in collect(keys(ship))])

panel = zeros(Int, (xmax, ymax))
for p in ship
    loc = p.first
    color = p.second
    panel[loc.x + abs(xmin) + 1, loc.y + abs(ymin) + 1] = color
end

print("-----------------------------------------------------------------------\n")
print("space police -- part one\n    panels painted      : $p1\n")
print("space police -- part two\n    identification code :\n")
for y in 1:ymax
    print("        ")
    for x in 1:xmax
        # print bottom to top to reflect the image and make it readable
        glyph = panel[x, ymax - y + 1] == 1 ? "#" : " "
        print("$glyph")
    end
    println()
end
print("-----------------------------------------------------------------------\n")
