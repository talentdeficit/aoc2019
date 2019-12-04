using aoc2019

first = 240298
last = 784956

p1 = aoc2019.password.check(first, last)
@assert p1 == 1150
p2 = aoc2019.password.check_strict(first, last)
@assert p2 == 748

print("----------------------------\n")
print("secure container -- part one\n    candidates : $p1\n")
print("secure container -- part two\n    candidates : $p2\n")
print("----------------------------\n")