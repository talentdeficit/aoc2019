.PHONY: all test one two three four five

all: one two three four five

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

five:
	julia --project=@. bin/five/run.jl