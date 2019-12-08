module wiring

export manhattan_distance, signal_delay

struct Point
    x::Int64
    y::Int64
end

function manhattan_distance(left, right)
    intersections = intersect(keys(trace(left)), keys(trace(right)))
    return minimum(map(p -> abs(p.x) + abs(p.y), collect(intersections)))
end

function signal_delay(left, right)
    l = trace(left)
    r = trace(right)
    intersections = intersect(keys(l), keys(r))
    return minimum(
        map(location -> l[location] + r[location],
            collect(intersections)
        )
    )
end

function trace(ops)
    x = 0
    y = 0
    acc::Dict{Point, Int64} = Dict()
    counter = 0
    for op in ops
        direction = SubString(op, 1, 1)
        distance = parse(Int, SubString(op, 2))
        for i = 1:distance
            location = move(direction, x, y)
            x = location.x
            y = location.y
            counter += 1
            if !haskey(acc, location)
                acc[location] = counter
            end
        end
    end
    return acc
end

function move(direction, x, y)
    if direction == "R"
        return Point(x + 1, y)
    elseif direction == "L"
        return Point(x - 1, y)
    elseif direction == "U"
        return Point(x, y + 1)
    elseif direction == "D"
        return Point(x, y - 1)
    end
end

end