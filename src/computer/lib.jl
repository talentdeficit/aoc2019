module computer

export run, next, State

using DelimitedFiles, Match

mutable struct State
    program::Array{Int64}
    instruction::Union{Int64,Nothing}
    relative_base::Int64
    inputs::Array{Int64}
    outputs::Array{Int64}
end

function run(program)
    state = State(program, 1, 0, [], [])
    while true
        state = next(state)
        state.instruction === nothing ? break : continue
    end
    return state
end

function run(program, inputs)
    state = State(program, 1, 0, inputs, [])
    while true
        state = next(state)
        state.instruction === nothing ? break : continue
    end
    return state
end

function next(state)
    program = state.program
    instruction = state.instruction
    rel = state.relative_base
    inputs = state.inputs
    outputs = state.outputs
    op = program[state.instruction]
    @match rem(op, 100) begin
        # ADD
        1 => begin
            x = rval(state, 1)
            y = rval(state, 2)
            dest = wval(state, 3)
            write(state, dest, x + y)
            state.instruction += 4
            return state
        end
        # MULTIPLY
        2 => begin
            x = rval(state, 1)
            y = rval(state, 2)
            dest = wval(state, 3)
            write(state, dest, x * y)
            state.instruction += 4
            return state
        end
        # INPUT
        3 => begin
            dest = wval(state, 1)
            if isempty(inputs)
                # block on waiting for input
                return state
            else
                input = pop!(inputs)
                write(state, dest, input)
                state.instruction += 2
                return state
            end
        end
        # OUTPUT
        4 => begin
            val = rval(state, 1)
            state.instruction += 2
            prepend!(state.outputs, val)
            return state
        end
        # JUMP IF TRUE
        5 => begin
            val = rval(state, 1)
            dest = rval(state, 2)
            val != 0 ?
                state.instruction = dest + 1 :
                state.instruction += 3
            return state
        end
        # JUMP IF FALSE
        6 => begin
            val = rval(state, 1)
            dest = rval(state, 2)
            val == 0 ?
                state.instruction = dest + 1 :
                state.instruction += 3
            return state
        end
        # LESS THAN
        7 => begin
            x = rval(state, 1)
            y = rval(state, 2)
            dest = wval(state, 3)
            x < y ? write(state, dest, 1) : write(state, dest, 0)
            state.instruction += 4
            return state
        end
        # EQUALS
        8 => begin
            x = rval(state, 1)
            y = rval(state, 2)
            dest = wval(state, 3)
            x == y ? write(state, dest, 1) : write(state, dest, 0)
            state.instruction += 4
            return state
        end
        # ADJUST RELATIVE BASE
        9 => begin
            x = rval(state, 1)
            state.relative_base += x
            state.instruction += 2
            return state
        end
        # HALT
        99 => return State(program, nothing, rel, inputs, outputs)
        _ => throw(ErrorException("unknown op code: $op"))
    end
end

function rval(state, parameter)
    program = state.program
    instruction = state.instruction
    rel = state.relative_base
    op = program[instruction]
    mode = rem(div(op, ^(10, parameter + 1)), 10)
    @match mode begin
        0 => begin
            idx = read(state, instruction + parameter)
            return read(state, idx + 1)
        end
        1 => return read(state, instruction + parameter)
        2 => begin
            offset = read(state, instruction + parameter)
            return read(state, rel + offset + 1)
        end
        _ => throw(ErrorException("unknown parameter mode: $mode"))
    end
end

function wval(state, parameter)
    program = state.program
    instruction = state.instruction
    rel = state.relative_base
    op = program[instruction]
    mode = rem(div(op, ^(10, parameter + 1)), 10)
    @match mode begin
        0 => begin
            idx = read(state, instruction + parameter)
            return idx + 1
        end
        2 => begin
            offset = read(state, instruction + parameter)
            return rel + offset + 1
        end
        _ => throw(ErrorException("unknown parameter mode: $mode"))
    end
end

function read(state, index)
    p = state.program
    return index > length(state.program) ? 0 : state.program[index]
end

function write(state, index, value)
    if index > length(state.program)
        mem = zeros(Int64, index - length(state.program))
        state.program = cat(state.program, mem, dims=(1))
    end
    state.program[index] = value
end

function load_program(path)
    return vec(readdlm(path, ',', Int64))
end

end