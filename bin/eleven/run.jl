using aoc2019.computer: load_program, read_output, provide_input, next, State
using aoc2019.hull: Point, Black, White, deploy, move!
using aoc2019.hull
using Match

input = joinpath(@__DIR__, "input")
p = load_program(input)

function paint(p, color)
    robot = deploy()
    ship = Dict{Point, Int}()
    ship[robot.location] = color
    m = State(p, 1, 0, [], [], false, false)
    while !m.halted
        c = hull.color(ship, robot.location)
        provide_input(m, c)
        m.blocked = false
        while !m.blocked && !m.halted
            m = next(m)
        end
        paint = read_output(m)
        turn = read_output(m)
        ship[robot.location] = paint
        move!(robot, turn)
    end
    return ship
end

ship = paint(copy(p), Black)
p1 = length(collect(keys(ship)))
@assert p1 == 1951

ship = paint(copy(p), White)
p2 = length(collect(keys(ship)))
@assert p2 == 249

xmax = maximum([p.x + 1 for p in collect(keys(ship))])
ymax = maximum([abs(p.y) + 1 for p in collect(keys(ship))])

panel = zeros(Int, (xmax, ymax))
for p in ship
    loc = p.first
    color = p.second
    panel[loc.x + 1, abs(loc.y) + 1] = color
end

print("-----------------------------------------------------------------------\n")
print("space police -- part one\n    panels painted      : $p1\n")
print("space police -- part two\n    identification code :\n")
for y in 1:ymax
    print("        ")
    for x in 1:xmax
        glyph = panel[x, y] == 1 ? "#" : " "
        print("$glyph")
    end
    println()
end
print("-----------------------------------------------------------------------\n")
