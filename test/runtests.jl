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