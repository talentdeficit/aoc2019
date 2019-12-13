module computer

export Context, io, run

using DelimitedFiles, Match

mutable struct Context
    program::Array{Int64,1}
    instruction::Int64
    relative_base::Int64
    debug::Bool
end

function io()
    return (Channel{Int64}(256), Channel{Int64}(256))
end

function run(program::Array{Int64,1}, debug=false)
    stdin, stdout = io()
    run(program, stdin, stdout, debug)
end

function run(program::Array{Int64,1}, input::Int64, debug=false)
    stdin, stdout = io()
    put!(stdin, input)
    run(program, stdin, stdout, debug)
end

function run(program::Array{Int64,1}, stdin::Channel{Int64}, stdout::Channel{Int64}, debug=false)
    c = Context(program, 1, 0, debug)
    while execute(c, stdin, stdout); end
    return program
end

function execute(context::Context, stdin::Channel{Int64}, stdout::Channel{Int64})
    context.debug && inspect(context, stdin, stdout)
    op = rem(context.program[context.instruction], 100)
    @match op begin
        # ADD
        1 => begin
            x = rval(context, 1)
            y = rval(context, 2)
            wval(context, 3, x + y)
            context.instruction += 4
        end
        # MULTIPLY
        2 => begin
            x = rval(context, 1)
            y = rval(context, 2)
            wval(context, 3, x * y)
            context.instruction += 4
        end
        # INPUT
        3 => begin
            val = take!(stdin)
            wval(context, 1, val)
            context.instruction += 2
        end
        # OUTPUT
        4 => begin
            val = rval(context, 1)
            put!(stdout, val)
            context.instruction += 2
        end
        # JUMP IF TRUE
        5 => begin
            val = rval(context, 1)
            dest = rval(context, 2)
            val != 0 ?
                context.instruction = dest + 1 :
                context.instruction += 3
        end
        # JUMP IF FALSE
        6 => begin
            val = rval(context, 1)
            dest = rval(context, 2)
            val == 0 ?
                context.instruction = dest + 1 :
                context.instruction += 3
        end
        # LESS THAN
        7 => begin
            x = rval(context, 1)
            y = rval(context, 2)
            x < y ? wval(context, 3, 1) : wval(context, 3, 0)
            context.instruction += 4
        end
        # EQUALS
        8 => begin
            x = rval(context, 1)
            y = rval(context, 2)
            x == y ? wval(context, 3, 1) : wval(context, 3, 0)
            context.instruction += 4
        end
        # ADJUST RELATIVE BASE
        9 => begin
            x = rval(context, 1)
            context.relative_base += x
            context.instruction += 2
        end
        # HALT
        99 => begin
            return false
        end
        _ => throw(ErrorException("unknown op code: $op"))
    end
    return true
end

function rval(context::Context, parameter::Int)
    program = context.program
    instruction = context.instruction
    rel = context.relative_base
    op = program[instruction]
    mode = rem(div(op, ^(10, parameter + 1)), 10)
    @match mode begin
        0 => begin
            idx = read(context, instruction + parameter)
            return read(context, idx + 1)
        end
        1 => return read(context, instruction + parameter)
        2 => begin
            offset = read(context, instruction + parameter)
            return read(context, rel + offset + 1)
        end
        _ => throw(ErrorException("unknown parameter mode: $mode"))
    end
end

function wval(context::Context, parameter::Int, value::Int64)
    program = context.program
    instruction = context.instruction
    rel = context.relative_base
    op = program[instruction]
    mode = rem(div(op, ^(10, parameter + 1)), 10)
    @match mode begin
        0 => begin
            idx = read(context, instruction + parameter)
            write(context, idx + 1, value)
        end
        1 => throw(ErrorException("invalid parameter mode: $mode"))
        2 => begin
            offset = read(context, instruction + parameter)
            write(context, rel + offset + 1, value)
        end
        _ => throw(ErrorException("unknown parameter mode: $mode"))
    end
end

function read(context::Context, index::Int64)
    return index > length(context.program) ? 0 : context.program[index]
end

function write(context::Context, index::Int64, value::Int64)
    if index > length(context.program)
        mem = zeros(Int64, index - length(context.program))
        context.program = cat(context.program, mem, dims=(1))
    end
    context.program[index] = value
end

function inspect(context::Context, stdin::Channel{Int64}, stdout::Channel{Int64})
    println("------------------")
    println("context :: $context")
    if isready(stdin)
        next_input = fetch(stdin)
        println("stdin :: $next_input")
    end
    if isready(stdout)
        next_output = fetch(stdout)
        println("stdout :: $next_output")
    end
end

function load_program(path::String)
    return vec(readdlm(path, ',', Int64))
end

end