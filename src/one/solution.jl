module one

    using DelimitedFiles

    function fuel_for_weight(weight)
        fld(weight, 3) - 2
    end

    function calculate_fuel(weights)
        return sum(fuel_for_weight, weights)
    end

    function total_fuel_for_weight(weight)
        fuel = fuel_for_weight(weight)
        fuel <= 0 ? 0 : fuel += total_fuel_for_weight(fuel)
    end

    function calculate_total_fuel(weights)
        return sum(total_fuel_for_weight, weights)
    end

    function read_weights(file)
        vec(readdlm(file, Int))
    end

    input = joinpath(@__DIR__, "input")
    weights = read_weights(input)
    p1 = calculate_fuel(weights)
    p2 = calculate_total_fuel(weights)
    print("----------------------------------------------\n")
    print("the tyranny of the rocket equation -- part one\n    fuel required : $p1\n")
    print("the tyranny of the rocket equation -- part two\n    fuel required : $p2\n")
    print("----------------------------------------------\n")

end