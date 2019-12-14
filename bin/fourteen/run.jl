using aoc2019.Nanofactory

input = joinpath(@__DIR__, "input")
eqs = readlines(input)

formulae = Nanofactory.parse_equations(eqs)

inventory = Dict("FUEL" => -1)
Nanofactory.produce(inventory, formulae)
p1 = abs(inventory["ORE"])
@assert p1 == 201324

low = 1
high = 1000000000000
while low < high
    global low
    global high
    guess = div(low + high + 1, 2)
    inventory = Dict("FUEL" => -1 * guess)
    Nanofactory.produce(inventory, formulae)
    ore = abs(inventory["ORE"])
    if ore < 1000000000000
        low = guess
    else
        high = guess - 1
    end
end

p2 = low
@assert p2 == 6326857


print("-----------------------------------------------------------------------\n")
print("space stoichiometry -- part one\n    ore  : $p1\n")
print("space stoichiometry -- part two\n    fuel : $p2\n")
print("-----------------------------------------------------------------------\n")