using aoc2019

first = 240298
last = 784956

p1 = aoc2019.password.check(first, last)
p2 = aoc2019.password.checkv2(first, last)

print("----------------------------\n")
print("secure container -- part one\n    candidates : $p1\n")
print("secure container -- part two\n    candidates : $p2\n")
print("----------------------------\n")