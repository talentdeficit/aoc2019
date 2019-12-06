module computer

    using DelimitedFiles, Match

    function run(program)
        state, _ = run(program, 1, [], [])
        return state
    end

    function run(program, inputs, outputs)
        return run(program, 1, inputs, outputs)
    end

    function run(program, instruction, inputs, outputs)
        op = program[instruction]
        @match rem(op, 100) begin
            # ADD
            1 => begin
                x = pval(op, program, instruction, 1)
                y = pval(op, program, instruction, 2)
                dest = program[instruction + 3]
                program[dest + 1] = x + y
                run(program, instruction + 4, inputs, outputs)
            end
            # MULTIPLY
            2 => begin
                x = pval(op, program, instruction, 1)
                y = pval(op, program, instruction, 2)
                dest = program[instruction + 3]
                program[dest + 1] = x * y
                run(program, instruction + 4, inputs, outputs)
            end
            # INPUT
            3 => begin
                dest = program[instruction + 1]
                program[dest + 1] = inputs[1]
                run(program, instruction + 2, inputs, outputs)
            end
            # OUTPUT
            4 => begin
                val = pval(op, program, instruction, 1)
                run(program, instruction + 2, inputs, append!(outputs, [val]))
            end
            # JUMP IF TRUE
            5 => begin
                val = pval(op, program, instruction, 1)
                dest = pval(op, program, instruction, 2)
                val != 0 ? run(program, dest + 1, inputs, outputs) :
                    run(program, instruction + 3, inputs, outputs)
            end
            # JUMP IF FALSE
            6 => begin
                val = pval(op, program, instruction, 1)
                dest = pval(op, program, instruction, 2)
                val == 0 ? run(program, dest + 1, inputs, outputs) :
                    run(program, instruction + 3, inputs, outputs)
            end
            # LESS THAN
            7 => begin
                x = pval(op, program, instruction, 1)
                y = pval(op, program, instruction, 2)
                dest = program[instruction + 3]
                x < y ? program[dest + 1] = 1 : program[dest + 1] = 0
                run(program, instruction + 4, inputs, outputs)
            end
            # EQUALS
            8 => begin
                x = pval(op, program, instruction, 1)
                y = pval(op, program, instruction, 2)
                dest = program[instruction + 3]
                x == y ? program[dest + 1] = 1 : program[dest + 1] = 0
                run(program, instruction + 4, inputs, outputs)
            end
            # HALT
            99 => return (program, outputs)
            _ => throw(ErrorException("unknown op code: $op"))
        end
    end

    function pval(op, program, instruction, parameter)
        mode = rem(div(op, ^(10, parameter + 1)), 10)
        @match mode begin
            0 => begin
                idx = program[instruction + parameter]
                return program[idx + 1]
            end
            1 => return program[instruction + parameter]
            _ => throw(ErrorException("unknown parameter mode: $mode"))
        end
    end

    function load_program(path)
        return readdlm(path, ',', Int)
    end

end