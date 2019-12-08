module star_chart

export total_orbits, total_transfers

using LightGraphs

function total_orbits(orbit_map)
    os = parse_map(orbit_map)
    (ps, g) = graph_orbits(os)
    return count_orbits(ps, g)
end

function total_transfers(orbit_map)
    os = parse_map(orbit_map)
    (ps, gr) = graph_orbits(os)
    me = orbiting(gr, ps["YOU"])
    santa = orbiting(gr, ps["SAN"])
    return length(a_star(gr, me, santa))
end

function orbiting(gr, body)
    return first(neighbors(gr, body))
end

function parse_map(orbits)
    return map(
      orbit -> split(orbit, ")"),
      orbits
    )
end

function graph_orbits(orbits)
    orbit_map = Graph()
    bodies = Dict{String, Int}()
    for orbit in orbits
        (parent, child) = orbit
        vp = assign_id_to_body(bodies, orbit_map, parent)
        vc = assign_id_to_body(bodies, orbit_map, child)
        add_edge!(orbit_map, vc, vp)
    end
    return (bodies, orbit_map)
end

function assign_id_to_body(bodies, orbit_map, body)
    if haskey(bodies, body)
        return bodies[body]
    else
        add_vertices!(orbit_map, 1)
        id = nv(orbit_map)
        bodies[body] = id
        return id
    end
end

function count_orbits(bodies, orbit_map)
    origin = bodies["COM"]
    count = 0
    for body in bodies
        (_, id) = body
        count += length(a_star(orbit_map, id, origin))
    end
    return count
end

end