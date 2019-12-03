# aoc 2019

solutions in julia

## run

```
[8:56:48] alisdair:aoc2019 git:(master) $ make one
julia --project=@. bin/one/run.jl
----------------------------------------------
the tyranny of the rocket equation -- part one
    fuel required : 3420719
the tyranny of the rocket equation -- part two
    fuel required : 5128195
----------------------------------------------
[8:57:52] alisdair:aoc2019 git:(master) $ make two
julia --project=@. bin/two/run.jl
------------------------------
2012 program alarm -- part one
    final value : 3101844
2012 program alarm -- part two
    nounverb    : 8478
------------------------------
...
```

## testing

```
[8:58:27] alisdair:aoc2019 git:(master) $ make test
julia --project=@. test/runtests.jl
Test Summary:                                  | Pass  Total
the tyranny of the rocket equation -- part one |    4      4
Test Summary:                                  | Pass  Total
the tyranny of the rocket equation -- part two |    3      3
Test Summary:                  | Pass  Total
1202 program alarm -- part one |    4      4
...
```