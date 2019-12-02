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