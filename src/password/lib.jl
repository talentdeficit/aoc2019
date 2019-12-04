module password

    using StatsBase

    function check(first::Int, last::Int)
        return count([iscandidate(pass) for pass in first:last])
    end

    function checkv2(first::Int, last::Int)
        return count([iscandidate(pass) && iscandidatev2(pass) for pass in first:last])
    end

    function iscandidate(password::String)
        iscandidate(parse(password, Int))
    end

    function iscandidate(password::Int)
        pass = digits(password)
        # password must be six characters
        size = length(pass)
        # password must be ascending, ie sorted smallest to biggest
        ascending = issorted(pass, rev=true)
        # password must use a digit twice
        repeated = length(sort(unique(pass))) < size

        return size == 6 && ascending && repeated
    end

    function iscandidatev2(password::String)
        iscandidate(parse(password, Int))
    end

    function iscandidatev2(password::Int)
        pass = digits(password)
        # password must use a digit exactly twice
        return !isempty(filter(x -> x == 2, collect(values(countmap(pass)))))
    end

end