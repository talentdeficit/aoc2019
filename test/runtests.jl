using Test, aoc2019

@testset "the tyranny of the rocket equation -- part one                          " begin
    @test aoc2019.fuel.total([12]) == 2
    @test aoc2019.fuel.total([14]) == 2
    @test aoc2019.fuel.total([1969]) == 654
    @test aoc2019.fuel.total([100756]) == 33583
end

@testset "the tyranny of the rocket equation -- part two                          " begin
    @test aoc2019.fuel.correct_total([14]) == 2
    @test aoc2019.fuel.correct_total([1969]) == 966
    @test aoc2019.fuel.correct_total([100756]) == 50346
end

@testset "1202 program alarm -- part one                                          " begin
    @test aoc2019.computer.run([1,0,0,0,99]) == [2,0,0,0,99]
    @test aoc2019.computer.run([2,3,0,3,99]) == [2,3,0,6,99]
    @test aoc2019.computer.run([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
    @test aoc2019.computer.run([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
end

@testset "crossed wires -- part one                                               " begin
    @test aoc2019.wiring.manhattan_distance(
        ["R75","D30","R83","U83","L12","D49","R71","U7","L72"],
        ["U62","R66","U55","R34","D71","R55","D58","R83"]
    ) == 159
    @test aoc2019.wiring.manhattan_distance(
        ["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R51"],
        ["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]
    ) == 135
end

@testset "crossed wires -- part two                                               " begin
    @test aoc2019.wiring.signal_delay(
        ["R75","D30","R83","U83","L12","D49","R71","U7","L72"],
        ["U62","R66","U55","R34","D71","R55","D58","R83"]
    ) == 610
    @test aoc2019.wiring.signal_delay(
        ["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R51"],
        ["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]
    ) == 410
end

@testset "secure container -- part one                                            " begin
    @test aoc2019.password.is_candidate(111111) == true
    @test aoc2019.password.is_candidate(223450) == false
    @test aoc2019.password.is_candidate(123789) == false
end

@testset "secure container -- part two                                            " begin
    @test aoc2019.password.is_candidate(112233) && aoc2019.password.is_candidate_strict(112233) == true
    @test aoc2019.password.is_candidate(123444) && aoc2019.password.is_candidate_strict(123444)== false
    @test aoc2019.password.is_candidate(111122) && aoc2019.password.is_candidate_strict(1111122)== true
end

@testset "sunny with a chance of asteroids -- part one                            " begin
    @test aoc2019.computer.run([1002,4,3,4,33]) == [1002,4,3,4,99]
end

@testset "sunny with a chance of asteroids -- part two                            " begin
    # equals tests
    @test aoc2019.computer.run([3,9,8,9,10,9,4,9,99,-1,8], [8], [])[2] == [1]
    @test aoc2019.computer.run([3,9,8,9,10,9,4,9,99,-1,8], [9], [])[2] == [0]
    @test aoc2019.computer.run([3,3,1108,-1,8,3,4,3,99], [8], [])[2] == [1]
    @test aoc2019.computer.run([3,3,1108,-1,8,3,4,3,99], [9], [])[2] == [0]
    # less than tests
    @test aoc2019.computer.run([3,9,7,9,10,9,4,9,99,-1,8], [7], [])[2] == [1]
    @test aoc2019.computer.run([3,9,7,9,10,9,4,9,99,-1,8], [8], [])[2] == [0]
    @test aoc2019.computer.run([3,9,7,9,10,9,4,9,99,-1,8], [9], [])[2] == [0]
    @test aoc2019.computer.run([3,3,1107,-1,8,3,4,3,99], [7], [])[2] == [1]
    @test aoc2019.computer.run([3,3,1107,-1,8,3,4,3,99], [8], [])[2] == [0]
    @test aoc2019.computer.run([3,3,1107,-1,8,3,4,3,99], [9], [])[2] == [0]
    # jump tests
    @test aoc2019.computer.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], [0], [])[2] == [0]
    @test aoc2019.computer.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], [99], [])[2] == [1]
    @test aoc2019.computer.run([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], [0], [])[2] == [0]
    # combined test
    @test aoc2019.computer.run([
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], [7], [])[2] == [999]
    @test aoc2019.computer.run([
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], [8], [])[2] == [1000]
    @test aoc2019.computer.run([
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], [9], [])[2] == [1001]
end

@testset "universal orbit map -- part one                                         " begin
    @test aoc2019.star_chart.total_orbits([
        "COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"
    ]) == 42
end

@testset "universal orbit map -- part two                                         " begin
    @test aoc2019.star_chart.total_transfers([
        "COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I",
        "E)J", "J)K", "K)L", "K)YOU", "I)SAN"
    ]) == 4
end