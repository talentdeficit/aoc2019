using aoc2019.sif: image, resolve, checksum

input = joinpath(@__DIR__, "input")
bits = [parse(Int, char) for char in readline(input)]
img = image(bits, 25, 6)

p1 = checksum(img)
@assert p1 == 2806

p2 = resolve(img)

print("-----------------------------------------------------------------------\n")
print("space image format -- part one\n    corruption check : $p1\n")
print("space image format -- part two\n    password         :\n")
for y in 1:6
    print("        ")
    for x in 1:25
        glyph = p2[x, y] == 1 ? "#" : " "
        print("$glyph")
    end
    println()
end
print("-----------------------------------------------------------------------\n")