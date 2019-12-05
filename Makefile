.PHONY: all test one two three four

all: one two three four

install:
	julia --project=@. -e 'using Pkg; Pkg.instantiate()'

test:
	julia --project=@. test/runtests.jl

one:
	julia --project=@. bin/one/run.jl

two:
	julia --project=@. bin/two/run.jl

three:
	julia --project=@. bin/three/run.jl

four:
	julia --project=@. bin/four/run.jl