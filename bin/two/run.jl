using aoc2019.computer: load_program, run

function nv(program)
    for i = 1:100
        for j = 1:100
            if nv(program, i, j)
                return 100 * i + j
            end
        end
    end
end

function nv(program, i, j)
    let new_program = copy(program)
        new_program[2] = i
        new_program[3] = j
        run(new_program)
        if first(new_program) == 19690720
            return true
        else
            return false
        end
    end
end

input = joinpath(@__DIR__, "input")
p = load_program(input)

program = copy(p)
run(program)
p1 = first(program)
@assert p1 == 3101844

p2 = nv(copy(p))
@assert p2 == 8478

print("-----------------------------------------------------------------------\n")
print("2012 program alarm -- part one\n    final value : $p1\n")
print("2012 program alarm -- part two\n    nounverb    : $p2\n")
print("-----------------------------------------------------------------------\n")