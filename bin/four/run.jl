using aoc2019.password: check, check_strict

first = 240298
last = 784956

p1 = check(first, last)
@assert p1 == 1150
p2 = check_strict(first, last)
@assert p2 == 748

print("-----------------------------------------------------------------------\n")
print("secure container -- part one\n    candidates : $p1\n")
print("secure container -- part two\n    candidates : $p2\n")
print("-----------------------------------------------------------------------\n")