.PHONY: current install test run

current:
	julia --project=@. bin/sixteen/run.jl

install:
	julia --project=@. -e 'using Pkg; Pkg.instantiate()'

test:
	julia --project=@. test/runtests.jl

run:
	julia --project=@. bin/$(day)/run.jl


