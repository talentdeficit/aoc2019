module fuel

    using DelimitedFiles

    function fuel_for_weight(weight)
        fld(weight, 3) - 2
    end

    function calculate_fuel(weights)
        return sum(fuel_for_weight, weights)
    end

    function fuel_for_weight_v2(weight)
        fuel = fuel_for_weight(weight)
        fuel <= 0 ? 0 : fuel += fuel_for_weight_v2(fuel)
    end

    function calculate_fuel_v2(weights)
        return sum(fuel_for_weight_v2, weights)
    end

    function read_weights(file)
        vec(readdlm(file, Int))
    end

end