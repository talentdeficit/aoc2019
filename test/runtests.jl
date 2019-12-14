using Test
using aoc2019.Fuel
using aoc2019.computer
using aoc2019.wiring
using aoc2019.password
using aoc2019.star_chart
using aoc2019.thrusters
using aoc2019.sif
using aoc2019.asteroids
using aoc2019.Nanofactory

@testset "the tyranny of the rocket equation -- part one                          " begin
    @test Fuel.total([12]) == 2
    @test Fuel.total([14]) == 2
    @test Fuel.total([1969]) == 654
    @test Fuel.total([100756]) == 33583
end

@testset "the tyranny of the rocket equation -- part two                          " begin
    @test Fuel.correct_total([14]) == 2
    @test Fuel.correct_total([1969]) == 966
    @test Fuel.correct_total([100756]) == 50346
end

@testset "1202 program alarm -- part one                                          " begin
    @test computer.run([1,0,0,0,99]) == [2,0,0,0,99]
    @test computer.run([2,3,0,3,99]) == [2,3,0,6,99]
    @test computer.run([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
    @test computer.run([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
end

@testset "crossed wires -- part one                                               " begin
    @test wiring.manhattan_distance(
        ["R75","D30","R83","U83","L12","D49","R71","U7","L72"],
        ["U62","R66","U55","R34","D71","R55","D58","R83"]
    ) == 159

    @test wiring.manhattan_distance(
        ["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R51"],
        ["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]
    ) == 135
end

@testset "crossed wires -- part two                                               " begin
    @test wiring.signal_delay(
        ["R75","D30","R83","U83","L12","D49","R71","U7","L72"],
        ["U62","R66","U55","R34","D71","R55","D58","R83"]
    ) == 610

    @test wiring.signal_delay(
        ["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R51"],
        ["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]
    ) == 410
end

@testset "secure container -- part one                                            " begin
    @test password.is_candidate(111111) == true
    @test password.is_candidate(223450) == false
    @test password.is_candidate(123789) == false
end

@testset "secure container -- part two                                            " begin
    @test password.is_candidate(112233) && password.is_candidate_strict(112233) == true
    @test password.is_candidate(123444) && password.is_candidate_strict(123444)== false
    @test password.is_candidate(111122) && password.is_candidate_strict(1111122)== true
end

@testset "sunny with a chance of asteroids -- part one                            " begin
    @test computer.run([1002,4,3,4,33]) == [1002,4,3,4,99]
end

@testset "sunny with a chance of asteroids -- part two                            " begin
    # equals tests
    stdin, stdout = io()
    put!(stdin, 8)
    @async computer.run([3,9,8,9,10,9,4,9,99,-1,8], stdin, stdout)
    @test take!(stdout) == 1

    stdin, stdout = io()
    put!(stdin, 9)
    @async computer.run([3,9,8,9,10,9,4,9,99,-1,8], stdin, stdout)
    @test take!(stdout) == 0

    stdin, stdout = io()
    put!(stdin, 8)
    @async computer.run([3,3,1108,-1,8,3,4,3,99], stdin, stdout)
    @test take!(stdout) == 1

    stdin, stdout = io()
    put!(stdin, 9)
    @async computer.run([3,3,1108,-1,8,3,4,3,99], stdin, stdout)
    @test take!(stdout) == 0

    # less than tests
    stdin, stdout = io()
    put!(stdin, 7)
    @async computer.run([3,9,7,9,10,9,4,9,99,-1,8], stdin, stdout)
    @test take!(stdout) == 1

    stdin, stdout = io()
    put!(stdin, 8)
    @async computer.run([3,9,7,9,10,9,4,9,99,-1,8], stdin, stdout)
    @test take!(stdout) == 0

    stdin, stdout = io()
    put!(stdin, 9)
    @async computer.run([3,9,7,9,10,9,4,9,99,-1,8], stdin, stdout)
    @test take!(stdout) == 0

    stdin, stdout = io()
    put!(stdin, 7)
    @async computer.run([3,3,1107,-1,8,3,4,3,99], stdin, stdout)
    @test take!(stdout) == 1

    stdin, stdout = io()
    put!(stdin, 8)
    @async computer.run([3,3,1107,-1,8,3,4,3,99], stdin, stdout)
    @test take!(stdout) == 0

    stdin, stdout = io()
    put!(stdin, 9)
    @async computer.run([3,3,1107,-1,8,3,4,3,99], stdin, stdout)
    @test take!(stdout) == 0

    # jump tests
    stdin, stdout = io()
    put!(stdin, 0)
    @async computer.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], stdin, stdout)
    @test take!(stdout) == 0

    stdin, stdout = io()
    put!(stdin, 99)
    @async computer.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], stdin, stdout)
    @test take!(stdout) == 1

    stdin, stdout = io()
    put!(stdin, 0)
    @async computer.run([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], stdin, stdout)
    @test take!(stdout) == 0

    # other
    stdin, stdout = io()
    put!(stdin, 7)
    @async computer.run(
        [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
            1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
            999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
        ],
        stdin,
        stdout
    )
    @test take!(stdout) == 999

    stdin, stdout = io()
    put!(stdin, 8)
    @async computer.run(
        [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
            1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
            999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
        ],
        stdin,
        stdout
    )
    @test take!(stdout) == 1000

    stdin, stdout = io()
    put!(stdin, 9)
    @async computer.run(
        [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
            1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
            999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
        ],
        stdin,
        stdout
    )
    @test take!(stdout) == 1001
end

@testset "universal orbit map -- part one                                         " begin
    @test star_chart.total_orbits([
        "COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"
    ]) == 42
end

@testset "universal orbit map -- part two                                         " begin
    @test star_chart.total_transfers([
        "COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I",
        "E)J", "J)K", "K)L", "K)YOU", "I)SAN"
    ]) == 4
end

@testset "amplification circuit -- part one                                       " begin
    @test thrusters.output(
        [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0],
        [4,3,2,1,0],
        0
    ) == 43210

    @test thrusters.output(
        [3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0],
        [0,1,2,3,4],
        0
    ) == 54321

    @test thrusters.output(
        [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
            1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0
        ],
        [1,0,4,3,2],
        0
    ) == 65210
end

@testset "amplification circuit -- part two                                       " begin
    @test thrusters.feedback_loop(
        [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,
            27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5
        ],
        [9,8,7,6,5],
        0
    ) == 139629729

    @test thrusters.feedback_loop(
        [3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,
            54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,
            55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10
        ],
        [9,7,8,5,6],
        0
    ) == 18216
end

@testset "space image format -- part one                                          " begin
    @test sif.checksum(sif.image([1,2,3,4,5,6,7,8,9,0,1,2], 3, 2)) == 1
    @test sif.checksum(sif.image([0,0,0,0,0,1,1,1,1,1,1,2], 2, 2)) == 3
end

@testset "space image format -- part two                                          " begin
    @test sif.resolve(sif.image([0,2,2,2,1,1,2,2,2,2,1,2,0,0,0,0], 2, 2)) == [0 1; 1 0]
end

@testset "sensor boost -- part one                                                " begin
    program = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
    stdin, stdout = computer.io()
    task = @async computer.run(copy(program), stdin, stdout)
    while !istaskdone(task); yield(); end
    close(stdout)
    @test [o for o in stdout] == program

    program = [1102,34915192,34915192,7,4,7,99,0]
    stdin, stdout = computer.io()
    task = @async computer.run(program, stdin, stdout)
    while !istaskdone(task); yield(); end
    @test length(digits(take!(stdout))) == 16

    program = [104,1125899906842624,99]
    stdin, stdout = computer.io()
    task = @async computer.run(program, stdin, stdout)
    while !istaskdone(task); yield(); end
    @test take!(stdout) == 1125899906842624
end

@testset "monitoring station -- part one                                          " begin
    map = asteroids.chart([".#..#", ".....", "#####", "....#", "...##"])
    (coords, visible) = asteroids.maxima(map)
    @test coords == asteroids.Point(4, 5)
    @test visible == 8

    map = asteroids.chart([
        "......#.#.",
        "#..#.#....",
        "..#######.",
        ".#.#.###..",
        ".#..#.....",
        "..#....#.#",
        "#..#....#.",
        ".##.#..###",
        "##...#..#.",
        ".#....####"
    ])
    (coords, visible) = asteroids.maxima(map)
    @test coords == asteroids.Point(6, 9)
    @test visible == 33

    map = asteroids.chart([
        "#.#...#.#.",
        ".###....#.",
        ".#....#...",
        "##.#.#.#.#",
        "....#.#.#.",
        ".##..###.#",
        "..#...##..",
        "..##....##",
        "......#...",
        ".####.###."
    ])
    (coords, visible) = asteroids.maxima(map)
    @test coords == asteroids.Point(2, 3)
    @test visible == 35

    map = asteroids.chart([
        ".#..##.###...#######",
        "##.############..##.",
        ".#.######.########.#",
        ".###.#######.####.#.",
        "#####.##.#.##.###.##",
        "..#####..#.#########",
        "####################",
        "#.####....###.#.#.##",
        "##.#################",
        "#####.##.###..####..",
        "..######..##.#######",
        "####.##.####...##..#",
        ".#####..#.######.###",
        "##...#.##########...",
        "#.##########.#######",
        ".####.#.###.###.#.##",
        "....##.##.###..#####",
        ".#.#.###########.###",
        "#.#.#.#####.####.###",
        "###.##.####.##.#..##"
    ])
    (coords, visible) = asteroids.maxima(map)
    @test coords == asteroids.Point(12, 14)
    @test visible == 210
end

@testset "monitoring station -- part two                                          " begin
    tau = 2 * atan(0, -1)
    map = asteroids.chart([
        ".#....#####...#..",
        "##...##.#####..##",
        "##...#...#.#####.",
        "..#.....X...###..",
        "..#.#.....#....##"
    ])
    asts = asteroids.sweep(map, Point(9, 4), atan(-1, 0) + tau, atan(-1, 0))
    @test asts[1] == Point(9, 2)
    @test asts[9] == Point(16, 2)
end

@testset "space stoichiometry -- part one                                         " begin
    formulae = Nanofactory.parse_equations([
        "10 ORE => 10 A"
        "1 ORE => 1 B"
        "7 A, 1 B => 1 C"
        "7 A, 1 C => 1 D"
        "7 A, 1 D => 1 E"
        "7 A, 1 E => 1 FUEL"
    ])
    inventory = Dict("FUEL" => -1)
    Nanofactory.produce(inventory, formulae)
    ore = abs(inventory["ORE"])
    @test ore == 31

    formulae = Nanofactory.parse_equations([
        "9 ORE => 2 A"
        "8 ORE => 3 B"
        "7 ORE => 5 C"
        "3 A, 4 B => 1 AB"
        "5 B, 7 C => 1 BC"
        "4 C, 1 A => 1 CA"
        "2 AB, 3 BC, 4 CA => 1 FUEL"
    ])
    inventory = Dict("FUEL" => -1)
    Nanofactory.produce(inventory, formulae)
    ore = abs(inventory["ORE"])
    @test ore == 165

    formulae = Nanofactory.parse_equations([
        "157 ORE => 5 NZVS"
        "165 ORE => 6 DCFZ"
        "44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL"
        "12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ"
        "179 ORE => 7 PSHF"
        "177 ORE => 5 HKGWZ"
        "7 DCFZ, 7 PSHF => 2 XJWVT"
        "165 ORE => 2 GPVTF"
        "3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT"
    ])
    inventory = Dict("FUEL" => -1)
    Nanofactory.produce(inventory, formulae)
    ore = abs(inventory["ORE"])
    @test ore == 13312

    formulae = Nanofactory.parse_equations([
        "2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG"
        "17 NVRVD, 3 JNWZP => 8 VPVL"
        "53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL"
        "22 VJHF, 37 MNCFX => 5 FWMGM"
        "139 ORE => 4 NVRVD"
        "144 ORE => 7 JNWZP"
        "5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC"
        "5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV"
        "145 ORE => 6 MNCFX"
        "1 NVRVD => 8 CXFTF"
        "1 VJHF, 6 MNCFX => 4 RFSQX"
        "176 ORE => 6 VJHF"
    ])
    inventory = Dict("FUEL" => -1)
    Nanofactory.produce(inventory, formulae)
    ore = abs(inventory["ORE"])
    @test ore == 180697

    formulae = Nanofactory.parse_equations([
        "171 ORE => 8 CNZTR"
        "7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL"
        "114 ORE => 4 BHXH"
        "14 VRPVC => 6 BMBT"
        "6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL"
        "6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT"
        "15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW"
        "13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW"
        "5 BMBT => 4 WPTQ"
        "189 ORE => 9 KTJDG"
        "1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP"
        "12 VRPVC, 27 CNZTR => 2 XDBXC"
        "15 KTJDG, 12 BHXH => 5 XCVML"
        "3 BHXH, 2 VRPVC => 7 MZWV"
        "121 ORE => 7 VRPVC"
        "7 XCVML => 6 RJRHP"
        "5 BHXH, 4 VRPVC => 5 LTCX"
    ])
    inventory = Dict("FUEL" => -1)
    Nanofactory.produce(inventory, formulae)
    ore = abs(inventory["ORE"])
    @test ore == 2210736
end

@testset "space stoichiometry -- part two                                         " begin
    formulae = Nanofactory.parse_equations([
        "157 ORE => 5 NZVS"
        "165 ORE => 6 DCFZ"
        "44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL"
        "12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ"
        "179 ORE => 7 PSHF"
        "177 ORE => 5 HKGWZ"
        "7 DCFZ, 7 PSHF => 2 XJWVT"
        "165 ORE => 2 GPVTF"
        "3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT"
    ])
    low = 1
    high = 1000000000000
    while low < high
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
    @test low == 82892753

    formulae = Nanofactory.parse_equations([
        "2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG"
        "17 NVRVD, 3 JNWZP => 8 VPVL"
        "53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL"
        "22 VJHF, 37 MNCFX => 5 FWMGM"
        "139 ORE => 4 NVRVD"
        "144 ORE => 7 JNWZP"
        "5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC"
        "5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV"
        "145 ORE => 6 MNCFX"
        "1 NVRVD => 8 CXFTF"
        "1 VJHF, 6 MNCFX => 4 RFSQX"
        "176 ORE => 6 VJHF"
    ])
    low = 1
    high = 1000000000000
    while low < high
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
    @test low == 5586022

    formulae = Nanofactory.parse_equations([
        "171 ORE => 8 CNZTR"
        "7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL"
        "114 ORE => 4 BHXH"
        "14 VRPVC => 6 BMBT"
        "6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL"
        "6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT"
        "15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW"
        "13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW"
        "5 BMBT => 4 WPTQ"
        "189 ORE => 9 KTJDG"
        "1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP"
        "12 VRPVC, 27 CNZTR => 2 XDBXC"
        "15 KTJDG, 12 BHXH => 5 XCVML"
        "3 BHXH, 2 VRPVC => 7 MZWV"
        "121 ORE => 7 VRPVC"
        "7 XCVML => 6 RJRHP"
        "5 BHXH, 4 VRPVC => 5 LTCX"
    ])
    low = 1
    high = 1000000000000
    while low < high
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
    @test low == 460664
end



