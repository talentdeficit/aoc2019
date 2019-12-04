module computer

    function run(program)
        run(program, 1)
    end

    function run(program, instruction)
        op = program[instruction]
        if op == 1
            ix = program[instruction + 1]
            x = program[ix + 1]
            iy = program[instruction + 2]
            y = program[iy + 1]
            dest = program[instruction + 3] + 1
            program[dest] = x + y
            run(program, instruction + 4)
        elseif op == 2
            ix = program[instruction + 1]
            x = program[ix + 1]
            iy = program[instruction + 2]
            y = program[iy + 1]
            dest = program[instruction + 3] + 1
            program[dest] = x * y
            run(program, instruction + 4)
        elseif op == 99
            return program
        else
            return []
        end
    end

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
            if run(new_program)[1] == 19690720
                return true
            else
                return false
            end
        end
    end

end