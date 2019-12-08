module dsn

function image(encoding::Array{Int,1}, width::Int, height::Int)
    layers = div(div(length(encoding), width), height)
    return reshape(encoding, (width, height, layers))
end

end