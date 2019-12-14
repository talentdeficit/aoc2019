module asteroids

export Point, tau, chart, maxima, sweep, destroy

const tau = 2 * atan(0, -1)

struct Point
    x::Int64
    y::Int64
end

function chart(map)
    coords = Set{Point}()
    for i = 1:length(map)
        for j = 1:length(map[i])
            if map[i][j] == '#'
                push!(coords, Point(j, i))
            end
        end
    end
    return coords
end

function angle(origin, target)
    r = atan(target.y - origin.y, target.x - origin.x)
    return r < atan(1, 0) ? r + tau : r
end

function visible(coords, origin)
    delete!(coords, origin)
    return length(unique([
        angle(origin, target) for target in coords
    ]))
end

function maxima(coords)
    acc = Dict()
    for ast in coords
        acc[ast] = visible(copy(coords), ast)
    end
    max = maximum(values(acc))
    return (first(keys(filter(ast -> ast.second == max, acc))), max)
end

function distance(origin, target)
    return abs(target.x - origin.x) + abs(target.y - origin.y)
end

function closest(origin, left, right)
    if left === nothing && right === nothing
        return nothing
    elseif left === nothing
        return right
    elseif right === nothing
        return left
    else
        return distance(origin, left) > distance(origin, right) ?
            right :
            left
    end
end

function sweep(coords, origin, start, finish)
    acc = Dict()
    for ast in coords
        dx = ast.x - origin.x
        dy = ast.y - origin.y
        r = atan(dy, dx)
        # rotate anything not in the -x,+y quadrant by tau so they sort from
        # 'north' (atan(-11, 0)) clockwise from highest to lowest
        nr = r < atan(-1, 0) ? r + tau : r
        current = get(acc, nr, nothing)
        acc[nr] = closest(origin, current, ast)
    end
    directions = keys(filter(entry -> entry.first >= finish && entry.first < start, acc))
    result = [acc[direction] for direction in sort(collect(directions))]
    return result
end

function destroy(coords, origin, start, finish)
    inrange = sweep(coords, origin, start, finish)
    [delete!(coords, ast) for ast in inrange]
end

end
