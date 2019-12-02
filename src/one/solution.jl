module one

    using DelimitedFiles

    function fuel_for_weight(weight)
        fld(weight, 3) - 2
    end

    function calculate_fuel(weights)
        return sum(fuel_for_weight, weights)
    end

    function total_fuel_for_weight(weight)
        fuel = fld(weight, 3) - 2
        fuel <= 0 ? 0 : fuel += total_fuel_for_weight(fuel)
    end

    function calculate_total_fuel(weights)
        return sum(total_fuel_for_weight, weights)
    end

    function read_weights(file)
        vec(readdlm(file, Int))
    end

end