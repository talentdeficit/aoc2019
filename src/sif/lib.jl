module sif

function image(encoding::Array{Int,1}, width::Int, height::Int)
    layers = div(div(length(encoding), width), height)
    return reshape(encoding, (width, height, layers))
end

function resolve(img::Array{Int,3})
    (width, height, layers) = size(img)
    result = zeros(Int, (width, height))
    for i in 1:width, j in 1:height
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
    return result
end

function checksum(img::Array{Int,3})
    (_, _, layers) = size(img)
    _, idx = findmin(map(layer -> count(x -> x == 0, img[:,:,layer]), 1:layers))
    ones = count(x -> x == 1, img[:,:,idx])
    twos = count(x -> x == 2, img[:,:,idx])
    return ones * twos
end

end