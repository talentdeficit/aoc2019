using Test
using aoc2019.fuel
using aoc2019.computer
using aoc2019.wiring
using aoc2019.password
using aoc2019.star_chart
using aoc2019.thrusters
using aoc2019.sif
using aoc2019.asteroids

@testset "the tyranny of the rocket equation -- part one                          " begin
    @test fuel.total([12]) == 2
    @test fuel.total([14]) == 2
    @test fuel.total([1969]) == 654
    @test fuel.total([100756]) == 33583
end

@testset "the tyranny of the rocket equation -- part two                          " begin
    @test fuel.correct_total([14]) == 2
    @test fuel.correct_total([1969]) == 966
    @test fuel.correct_total([100756]) == 50346
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