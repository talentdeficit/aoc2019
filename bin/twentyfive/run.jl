using aoc2019.computer

input = joinpath(@__DIR__, "input")
p = computer.load_program(input)

stdin, stdout = computer.io()
task = @async computer.run(copy(p), stdin, stdout)

while !istaskdone(task)
    sleep(.05)
    while isready(stdout)
        c = take!(stdout)
        print(convert(Char, c))
    end
    print("\$ ")
    cmd = readline()
    for c in cmd put!(stdin, c) end
    put!(stdin, '\n')
end