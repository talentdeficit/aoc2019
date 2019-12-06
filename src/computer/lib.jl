module computer

    using DelimitedFiles, Match

    function run(program)
        run(program, 1)
    end

    function run(program, instruction)
        op = program[instruction]
        @match op begin
            1 => begin
                    ix = program[instruction + 1]
                    x = program[ix + 1]
                    iy = program[instruction + 2]
                    y = program[iy + 1]
                    dest = program[instruction + 3] + 1
                    program[dest] = x + y
                    run(program, instruction + 4)
                end
            2 => begin
                    ix = program[instruction + 1]
                    x = program[ix + 1]
                    iy = program[instruction + 2]
                    y = program[iy + 1]
                    dest = program[instruction + 3] + 1
                    program[dest] = x * y
                    run(program, instruction + 4)
                end
            99 => return program
            _ => throw(ErrorException("unknown op code"))
        end
    end

    function load_program(path)
        return readdlm(path, ',', Int)
    end

end