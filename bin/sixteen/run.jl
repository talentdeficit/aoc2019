input = joinpath(@__DIR__, "input")
raw = readline(input)
digits = [parse(Int, char) for char in raw]
offset = parse(Int, raw[1:7])


base = [0, 1, 0, -1]
ex = [1, 2, 3, 4, 5, 6, 7, 8]

function pattern(n)
    acc = []
    for digit in base
        for i in 1:n
            push!(acc, digit)
        end
    end
    shift!(reverse!(acc))
    return acc
end

function shift!(pattern)
    v = pop!(pattern)
    prepend!(pattern, [v])
end

function reduce(n)
    while abs(n) > 9
        n = rem(n, 10)
    end
    return abs(n)
end

function output(input, base)
    acc::Array{Int, 1} = []
    for i in 1:length(input)
        mask = pattern(i)
        t = []
        for digit in input
            m = pop!(mask)
            prepend!(mask, [m])
            push!(t, digit * m)
        end
        push!(acc, reduce(sum(t)))
    end
    return acc
end

answer = digits
for i = 1:100
    global answer = output(answer, base)
end

p1 = answer[1:8]
@assert p1 == [8, 4, 9, 7, 0, 7, 2, 6]


expanded = []
for i = 1:10000
    append!(expanded, digits)
end

answer = expanded[offset + 1:length(expanded)]
for i in 1:100
    global answer = reverse!(map(x -> mod(x, 10), cumsum(reverse!(answer))))
end

p2 = answer[1:8]
@assert p2 == [4, 7, 6, 6, 4, 4, 6, 9]

print("-----------------------------------------------------------------------\n")
print("flawed frequency transmission -- part one\n    message : $p1\n")
print("flawed frequency transmission -- part two\n    message : $p2\n")
print("-----------------------------------------------------------------------\n")