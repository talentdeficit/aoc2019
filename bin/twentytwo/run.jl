using Match
using Test

input = joinpath(@__DIR__, "input")
raw = readlines(input)

struct Operation
    name::String
    value::Int
end

function operations(lines)
    acc = []
    for line in lines
        if startswith(line, "cut")
            _, n = split(line)
            push!(acc, Operation("cut", parse(Int, n)))
        elseif startswith(line, "deal into")
            push!(acc, Operation("reverse", 0))
        elseif startswith(line, "deal with")
            _, _, _, n = split(line)
            push!(acc, Operation("deal", parse(Int, n)))
        end
    end
    return acc
end

deal = (c, n) -> return mod(-1 * c - 1, n)
inc = (c, n, i) -> return mod(c * i, n)
cut = (c, n, i) -> return mod(c - i, n)

function shuffle(idx, deck, ops)
    c = idx
    n = deck
    for op in ops
        @match op.name begin
            "cut" => begin
                c = cut(c, n, op.value)
            end
            "reverse" => begin
                c = deal(c, n)
            end
            "deal" => begin
                c = inc(c, n, op.value)
            end
        end
    end
    return c
end


function fshuffle(idx, deck, ops, iterations)
    offset, increment = BigInt(0), BigInt(1)
    for op in ops
        @match op.name begin
            "cut" => begin
                n = mod(op.value, deck)
                offset = mod(offset + n, deck)
            end
            "reverse" => begin
                increment = mod(-1 * increment, deck)
                offset = mod(-1 * offset - 1, deck)
            end
            "deal" => begin
                n = invmod(mod(op.value, deck), deck)
                increment = mod(increment * n, deck)
                offset = mod(offset * n, deck)
            end
        end
    end
    i = powermod(increment, iterations, deck)
    o = if increment != 1
        (i - 1) * invmod(increment - 1, deck)
    else
        iterations
    end
    return mod(i * idx + o * offset, deck)
end

ops = operations(raw)
p1 = shuffle(2019, 10007, ops)
@assert p1 == 3589

reverse!(ops)
p2 = fshuffle(2020, 119315717514047, ops, 101741582076661)
@assert p2 == 4893716342290


print("-----------------------------------------------------------------------\n")
print("slam shuffle -- part one\n    card: $p1\n")
print("slam shuffle -- part two\n    card: $p2\n")
print("-----------------------------------------------------------------------\n")