module Fuel

export total, correct_total

function fuel_for_weight(weight)
    fld(weight, 3) - 2
end

function total(weights)
    return sum(fuel_for_weight, weights)
end

function correct_fuel_for_weight(weight)
    fuel = fuel_for_weight(weight)
    fuel <= 0 ? 0 : fuel += correct_fuel_for_weight(fuel)
end

function correct_total(weights)
    return sum(correct_fuel_for_weight, weights)
end

end