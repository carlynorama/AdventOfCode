let test0 = """
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
"""

let test2 = """
2
4
5
5
11
8
8
5
"""

let test1 = """
mul(2,4)
mul(5,5)
mul(11,8)
mul(8,5)
"""

let test4: String = """
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
"""