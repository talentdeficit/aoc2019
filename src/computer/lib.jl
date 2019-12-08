module computer

export run, next, State

using DelimitedFiles, Match

mutable struct State
    program::Array{Int}
    instruction::Union{Int,Nothing}
    inputs::Array{Int}
    outputs::Array{Int}
end

function run(program)
    state = State(program, 1, [], [])
    while true
        state = next(state)
        state.instruction === nothing ? break : continue
    end
    return state.program
end

function run(program, inputs)
    state = State(program, 1, inputs, [])
    while true
        state = next(state)
        state.instruction === nothing ? break : continue
    end
    return (state.program, first(state.outputs))
end

function next(state)
    instruction = state.instruction
    program = state.program
    inputs = state.inputs
    outputs = state.outputs
    op = program[state.instruction]
    @match rem(op, 100) begin
        # ADD
        1 => begin
            x = pval(op, program, instruction, 1)
            y = pval(op, program, instruction, 2)
            dest = program[instruction + 3]
            program[dest + 1] = x + y
            state.instruction += 4
            next(state)
        end
        # MULTIPLY
        2 => begin
            x = pval(op, program, instruction, 1)
            y = pval(op, program, instruction, 2)
            dest = program[instruction + 3]
            program[dest + 1] = x * y
            state.instruction += 4
            next(state)
        end
        # INPUT
        3 => begin
            dest = program[instruction + 1]
            if isempty(inputs)
                # block on waiting for input
                return state
            else
                input = pop!(inputs)
                program[dest + 1] = input
                state.instruction += 2
                next(state)
            end
        end
        # OUTPUT
        4 => begin
            val = pval(op, program, instruction, 1)
            state.instruction += 2
            prepend!(state.outputs, val)
            next(state)
        end
        # JUMP IF TRUE
        5 => begin
            val = pval(op, program, instruction, 1)
            dest = pval(op, program, instruction, 2)
            val != 0 ?
                state.instruction = dest + 1 :
                state.instruction += 3
            next(state)
        end
        # JUMP IF FALSE
        6 => begin
            val = pval(op, program, instruction, 1)
            dest = pval(op, program, instruction, 2)
            val == 0 ?
                state.instruction = dest + 1 :
                state.instruction += 3
            next(state)
        end
        # LESS THAN
        7 => begin
            x = pval(op, program, instruction, 1)
            y = pval(op, program, instruction, 2)
            dest = program[instruction + 3]
            x < y ? program[dest + 1] = 1 : program[dest + 1] = 0
            state.instruction += 4
            next(state)
        end
        # EQUALS
        8 => begin
            x = pval(op, program, instruction, 1)
            y = pval(op, program, instruction, 2)
            dest = program[instruction + 3]
            x == y ? program[dest + 1] = 1 : program[dest + 1] = 0
            state.instruction += 4
            next(state)
        end
        # HALT
        99 => return State(program, nothing, inputs, outputs)
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