using aoc2019.computer: load_program, io, run

input = joinpath(@__DIR__, "input")
p = load_program(input)


function damage(stdout, display=false)
    for thing in stdout
        if thing > 256
            return thing
        elseif display
            c = convert(Char, thing)
            print("$c")
        end
    end
end

function program(stdin, input)
    for char in input
        put!(stdin, char)
    end
end

walkcode = """
NOT A T
OR T J
NOT B T
OR T J
NOT C T
OR T J
AND D J
WALK
"""

runcode = """
NOT A J
NOT B T
OR T J
NOT C T
OR T J
AND D J
NOT E T
AND H T
OR E T
AND T J
RUN
"""

stdin, stdout = io()
task = @async run(copy(p), stdin, stdout)

program(stdin, walkcode)

while !istaskdone(task); yield() end
close(stdout)

p1 = damage(stdout)
@assert p1 == 19353074


stdin, stdout = io()
task = @async run(copy(p), stdin, stdout)

program(stdin, runcode)

while !istaskdone(task); yield() end
close(stdout)

p2 = damage(stdout)
@assert p2 == 1147582556


print("-----------------------------------------------------------------------\n")
print("springdroid adventure -- part one\n    damage : $p1\n")
print("springdroid adventure -- part two\n    damage : $p2\n")
print("-----------------------------------------------------------------------\n")

