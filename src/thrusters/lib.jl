module thrusters

export output, feedback_loop

using aoc2019.computer

function output(program, phases, initial)
    signal = initial
    for phase in phases
        p = copy(program)
        state = computer.run(p, [signal, phase])
        signal = first(state.outputs)
    end
    return first(signal)
end

function feedback_loop(program, phases, initial)
    amps = initialize_amplifiers(program, phases, initial)
    signal = nothing
    while true
        amp = pop!(amps)
        if amp.instruction !== nothing
            amp = computer.next(amp)
        end
        # copy output to next amplifier
        next = pop!(amps)
        for o in amp.outputs
            signal = o
            prepend!(next.inputs, [pop!(amp.outputs)])
        end
        push!(amps, next)
        # return current amplifier to queue
        prepend!(amps, [amp])
        # if all amplifiers are finished running, halt
        if all(map(a -> a.halted == true, amps))
            break;
        end
    end
    # this should be the last output signal
    return signal
end

function initialize_amplifiers(program, phases, initial)
    amps = reverse([computer.State(copy(program), 1, 0, [phase], [], false) for phase in phases])
    # provide initial signal to first amp
    first = pop!(amps)
    first.inputs = prepend!(first.inputs, [0])
    push!(amps, first)
    return amps
end

end