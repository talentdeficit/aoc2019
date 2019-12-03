using Test, aoc2019

@testset "the tyranny of the rocket equation -- part one" begin
    @test aoc2019.one.calculate_fuel(vec([12])) == 2
    @test aoc2019.one.calculate_fuel(vec([14])) == 2
    @test aoc2019.one.calculate_fuel(vec([1969])) == 654
    @test aoc2019.one.calculate_fuel(vec([100756])) == 33583
end

@testset "the tyranny of the rocket equation -- part two" begin
    @test aoc2019.one.calculate_total_fuel(vec([14])) == 2
    @test aoc2019.one.calculate_total_fuel(vec([1969])) == 966
    @test aoc2019.one.calculate_total_fuel(vec([100756])) == 50346
end

@testset "1202 program alarm -- part one" begin
    @test aoc2019.two.run([1,0,0,0,99]) == [2,0,0,0,99]
    @test aoc2019.two.run([2,3,0,3,99]) == [2,3,0,6,99]
    @test aoc2019.two.run([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
    @test aoc2019.two.run([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
end

@testset "crossed wires -- part one" begin
    @test aoc2019.three.manhattan_distance(
        ["R75","D30","R83","U83","L12","D49","R71","U7","L72"],
        ["U62","R66","U55","R34","D71","R55","D58","R83"]
    ) == 159
    @test aoc2019.three.manhattan_distance(
        ["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R51"],
        ["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]
    ) == 135
end

@testset "crossed wires -- part two" begin
    @test aoc2019.three.signal_delay(
        ["R75","D30","R83","U83","L12","D49","R71","U7","L72"],
        ["U62","R66","U55","R34","D71","R55","D58","R83"]
    ) == 610
    @test aoc2019.three.signal_delay(
        ["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R51"],
        ["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]
    ) == 410
end