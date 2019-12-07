module password

    using StatsBase

    function check(first::Int, last::Int)
        return count([is_candidate(pass) for pass in first:last])
    end

    function check_strict(first::Int, last::Int)
        return count([is_candidate(pass) && is_candidate_strict(pass) for pass in first:last])
    end

    function is_candidate(password::String)
        is_candidate(parse(password, Int))
    end

    function is_candidate(password::Int)
        pass = digits(password)
        # password must be six characters
        size = length(pass)
        # password must be ascending, ie sorted smallest to biggest
        ascending = issorted(pass, rev=true)
        # password must use a digit twice
        repeated = length(sort(unique(pass))) < size

        return size == 6 && ascending && repeated
    end

    function is_candidate_strict(password::String)
        is_candidate_strict(parse(password, Int))
    end

    function is_candidate_strict(password::Int)
        pass = digits(password)
        # password must use a digit exactly twice
        return 2 in values(countmap(pass))
    end

end
