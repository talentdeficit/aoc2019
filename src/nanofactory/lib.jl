module Nanofactory

function produce(inventory, formulae)
    targets = filter(produceable, inventory)
    while !isempty(targets)
        element, deficit = pop!(targets)
        reagents, produced = formulae[element]
        m = ceil(Int, abs(deficit) / produced)
        for (reagent, qty) in reagents
            current = get(inventory, reagent, 0)
            inventory[reagent] = current - (m * qty)
        end
        inventory[element] += (m * produced)
        targets = filter(produceable, inventory)
    end
end

function produceable(kv)
    return kv.first != "ORE" && kv.second < 0
end

function parse_equations(reactions::Array{String, 1})
    formulae = Dict{String,Pair{Array{Pair{String,Int},1},Int}}()
    for reaction in reactions
        rs, product = split(reaction, "=>")
        qty, element = split(strip(product), " ")
        reagents = parse_reagents(convert(String, rs))
        formulae[convert(String, element)] = Pair(reagents, parse(Int, qty))
    end
    return formulae
end

function parse_reagents(reagents::String)
    acc::Array{Pair{String,Int}, 1} = []
    for reagent in split(strip(reagents), ",")
        qty, element = split(strip(reagent), " ")
        push!(acc, Pair(convert(String, element), parse(Int, qty)))
    end
    return acc
end

end