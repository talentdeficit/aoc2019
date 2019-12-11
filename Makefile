.PHONY: all test one two three four five six seven eight nine ten eleven

all: one two three four five six seven eight nine ten eleven

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

six:
	julia --project=@. bin/six/run.jl

seven:
	julia --project=@. bin/seven/run.jl

eight:
	julia --project=@. bin/eight/run.jl

nine:
	julia --project=@. bin/nine/run.jl

ten:
	julia --project=@. bin/ten/run.jl

eleven:
	julia --project=@. bin/eleven/run.jl