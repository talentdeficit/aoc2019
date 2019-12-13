mutable struct Moon
    x::Int
    y::Int
    z::Int
    i::Int
    j::Int
    k::Int
end

function gravity(moons::Array{Moon,1})
    attract(moons[1], moons[2])
    attract(moons[1], moons[3])
    attract(moons[1], moons[4])
    attract(moons[2], moons[3])
    attract(moons[2], moons[4])
    attract(moons[3], moons[4])
end

function attract(left::Moon, right::Moon)
    if left.x < right.x
        left.i += 1
        right.i += -1
    elseif left.x > right.x
        left.i += -1
        right.i += 1
    else
    end
    if left.y < right.y
        left.j += 1
        right.j += -1
    elseif left.y > right.y
        left.j += -1
        right.j += 1
    else
    end
    if left.z < right.z
        left.k += 1
        right.k += -1
    elseif left.z > right.z
        left.k += -1
        right.k += 1
    else
    end
end

function velocity(moons::Array{Moon,1})
    for moon in moons
        moon.x += moon.i
        moon.y += moon.j
        moon.z += moon.k
    end
end

function potential(moon::Moon)
    return abs(moon.x) + abs(moon.y) + abs(moon.z)
end

function kinetic(moon::Moon)
    return abs(moon.i) + abs(moon.j) + abs(moon.k)
end

function energy(moon::Moon)
    p = potential(moon)
    k = kinetic(moon)
    return p * k
end

function simulate(moons)
    for i in 1:1000
        gravity(moons)
        velocity(moons)
    end
    return sum([energy(moon) for moon in moons])
end

function cycle(moons)
    xs = [(copy(m.x), copy(m.i)) for m in moons]
    x = nothing
    ys = [(copy(m.y), copy(m.j)) for m in moons]
    y = nothing
    zs = [(copy(m.z), copy(m.k)) for m in moons]
    z = nothing
    i = 0
    while true
        i += 1
        gravity(moons)
        velocity(moons)
        if x === nothing
            xt = [(copy(m.x), copy(m.i)) for m in moons]
            if xs == xt
                x = i
            end
        end
        if y === nothing
            yt = [(copy(m.y), copy(m.j)) for m in moons]
            if ys == yt
                y = i
            end
        end
        if z === nothing
            zt = [(copy(m.z), copy(m.k)) for m in moons]
            if zs == zt
                z = i
            end
        end
        x !== nothing && y !== nothing && z !== nothing ? break : continue
    end
    return lcm(lcm(x, y), z)
end

moons = [
    Moon(-3, 10, -1, 0, 0, 0),
    Moon(-12, -10, -5, 0, 0, 0),
    Moon(-9, 0, 10, 0, 0, 0),
    Moon(7, -5, -3, 0, 0, 0)
]

p1 = simulate(moons)
@assert p1 == 10944


moons = [
    Moon(-3, 10, -1, 0, 0, 0),
    Moon(-12, -10, -5, 0, 0, 0),
    Moon(-9, 0, 10, 0, 0, 0),
    Moon(7, -5, -3, 0, 0, 0)
]

p2 = cycle(moons)
@assert p2 == 484244804958744

print("-----------------------------------------------------------------------\n")
print("the n-body problem -- part one\n    total energy : $p1\n")
print("the n-body problem -- part two\n    t-stop       : $p2\n")
print("-----------------------------------------------------------------------\n")