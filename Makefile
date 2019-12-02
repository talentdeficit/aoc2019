.PHONY: one two

all: one two

one:
	julia --project=@. src/one/solution.jl

two:
	julia --project=@. src/two/solution.jl