using Test
using aoc2019.fuel
using aoc2019.computer
using aoc2019.wiring
using aoc2019.password
using aoc2019.star_chart
using aoc2019.thrusters
using aoc2019.sif

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
    @test computer.run([3,9,8,9,10,9,4,9,99,-1,8], [8])[2] == 1
    @test computer.run([3,9,8,9,10,9,4,9,99,-1,8], [9])[2] == 0
    @test computer.run([3,3,1108,-1,8,3,4,3,99], [8])[2] == 1
    @test computer.run([3,3,1108,-1,8,3,4,3,99], [9])[2] == 0
    # less than tests
    @test computer.run([3,9,7,9,10,9,4,9,99,-1,8], [7])[2] == 1
    @test computer.run([3,9,7,9,10,9,4,9,99,-1,8], [8])[2] == 0
    @test computer.run([3,9,7,9,10,9,4,9,99,-1,8], [9])[2] == 0
    @test computer.run([3,3,1107,-1,8,3,4,3,99], [7])[2] == 1
    @test computer.run([3,3,1107,-1,8,3,4,3,99], [8])[2] == 0
    @test computer.run([3,3,1107,-1,8,3,4,3,99], [9])[2] == 0
    # jump tests
    @test computer.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], [0])[2] == 0
    @test computer.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], [99])[2] == 1
    @test computer.run([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], [0])[2] == 0
    # combined test
    @test computer.run([
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], [7])[2] == 999
    @test computer.run([
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], [8])[2] == 1000
    @test computer.run([
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], [9])[2] == 1001
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