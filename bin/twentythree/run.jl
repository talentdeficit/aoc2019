using aoc2019.computer

input = joinpath(@__DIR__, "input")
p = computer.load_program(input)

struct NIC
    stdin::Channel{Int64}
    stdout::Channel{Int64}
end

function init(p::Array{Int,1}, stdout::Channel{Int64})
    nics = Dict{Int, Channel{Int64}}()
    for i in 0:49
        stdin = Channel{Int64}(Inf)
        nics[i] = stdin
        @async computer.run(copy(p), stdin, stdout)
        put!(stdin, i)
        ## hack to get nics started
        put!(stdin, -1)
    end
    return nics
end

function run(listen::Channel{Int64}, nics::Dict{Int, Channel{Int64}})
    nat = nothing
    first = nothing
    last = nothing
    idle = false
    while true
        yield()
        while isready(listen)
            address = take!(listen)
            x = take!(listen)
            y = take!(listen)
            if address == 255
                nat = (x, y)
                if first === nothing first = y end
            else
                dst = nics[address]
                put!(dst, x)
                put!(dst, y)
            end
            idle = false
        end
        if idle && nat !== nothing
            origin = nics[0]
            x, y = nat
            put!(origin, x)
            put!(origin, y)
            if y === last break end
            last = y
        end
        idle = true
    end
    return (first, last)
end

stdout = Channel{Int64}(Inf)
nics = init(p, stdout)
p1, p2 = run(stdout, nics)
@show p1, p2
@assert p1 == 26779
@assert p2 == 19216


print("-----------------------------------------------------------------------\n")
print("category six -- part one\n    first y : $p1\n")
print("category six -- part two\n    last y  : $p2\n")
print("-----------------------------------------------------------------------\n")