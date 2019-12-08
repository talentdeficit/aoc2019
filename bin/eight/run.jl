using aoc2019.dsn: image

input = joinpath(@__DIR__, "input")
bits = [parse(Int, char) for char in readline(input)]
img = image(bits, 25, 6)
layers = size(img)[3]
_, idx = findmin(map(layer -> count(x -> x == 0, img[:,:,layer]), 1:layers))
ones = count(x -> x == 1, img[:,:,idx])
twos = count(x -> x == 2, img[:,:,idx])
p1 = ones * twos
@assert p1 == 2806

result = zeros(Int, (25, 6))
for i in 1:25, j in 1:6
    for k in 1:layers
        if img[i,j,k] == 2
            continue
        elseif img[i,j,k] == 0
            result[i,j] = 0
            break
        elseif img[i,j,k] == 1
            result[i,j] = 1
            break
        end
    end
end

print("-----------------------------------------------------------------------\n")
print("space image format -- part one\n    corruption check : $p1\n")
print("space image format -- part two\n    password         :\n")
for y in 1:6
    print("        ")
    for x in 1:25
        glyph = result[x, y] == 1 ? "#" : " "
        print("$glyph")
    end
    println()
end
print("-----------------------------------------------------------------------\n")