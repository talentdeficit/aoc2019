module thrusters

export output, feedback_loop

using aoc2019.computer

function output(program, phases, initial)
    ## setup computer io
    io = [Channel{Int64}(256) for phase in phases]
    ## add a channel for the thruster
    thruster = Channel{Int64}(256)
    append!(io, [thruster])
    for i in 1:length(phases)
        put!(io[i], phases[i])
    end
    ## start computers
    for i in 1:length(phases)
        @async computer.run(copy(program), io[i], io[i + 1])
    end
    ## provide initial signal
    put!(io[1], initial)
    ## read input to thruster
    return take!(thruster)
end

function feedback_loop(program, phases, initial)
    ## setup computer io
    io = [Channel{Int64}(256) for phase in phases]
    for i in 1:length(phases)
        put!(io[i], phases[i])
    end
    ## start amplifiers
    amps = []
    for i in 1:length(phases)
        amp = @async computer.run(copy(program), io[i], io[mod(i + 1, 1:length(phases))])
        push!(amps, amp)
    end
    ## provide initial signal
    put!(io[1], initial)
    ## wait for all computers to halt
    while !all([istaskdone(amp) for amp in amps]); yield(); end
    ## get any outputs -- there should only be one
    for channel in io
        if isready(channel)
            return take!(channel)
        end
    end
end


end