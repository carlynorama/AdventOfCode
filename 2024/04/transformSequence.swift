//https://stackoverflow.com/questions/32920002/how-to-transpose-an-array-of-strings/32922962#32922962
extension Sequence where
    Element: Collection,
    Element.Index == Int
{
    func rotatingCCW(prefixWithMaxLength max: Int = .max) -> [[Element.Element]] {
        var o: [[Element.Element]] = []
        let n = Swift.min(max, self.min{ $0.count < $1.count }?.count ?? 0)
        o.reserveCapacity(n)
        for i in (0 ..< n).reversed() {
            o.append(map{ $0[i] })
        }
        return o
    }
    
    //0,0 remains 0,0
    func transposing(prefixWithMaxLength max: Int = .max) -> [[Element.Element]] {
        var o: [[Element.Element]] = []
        let n = Swift.min(max, self.min{ $0.count < $1.count }?.count ?? 0)
        o.reserveCapacity(n)
        for i in 0 ..< n {
            o.append(map{ $0[i] })
        }
        return o
    }


    func flippingHorizontal(prefixWithMaxLength max: Int = .max) -> [[Element.Element]] {
        rotatingCCW(prefixWithMaxLength: max)
        .transposing(prefixWithMaxLength: max)
        //return interim
    }

    func flippingVertical(prefixWithMaxLength max: Int = .max) -> [[Element.Element]] {
        transposing(prefixWithMaxLength: max)
        .rotatingCCW(prefixWithMaxLength: max)
        //return interim
    }
}

func transpose<T>(input: [[T]]) -> [[T]] {
    if input.isEmpty { return [[T]]() }
    let count = input[0].count
    var out = [[T]](repeating: [T](), count: count)
    for outer in input {
        for (index, inner) in outer.enumerated() {
            out[index].append(inner)
        }
    }

    return out
}

func makeDiagonals<T>(input: [[T]]) -> [[T]] {
    if input.isEmpty { return [[T]]() }
    let width = input[0].count
    let height = input.count
    var result = [[T]](repeating: [T](), count: width+height-1)
    
    for y in 0..<height {
        for x in 0..<width {
            result[x+y].append(input[y][x])
        }
    }
    return result
}

let transformTestData = """
ABCDE
FGHIJ
KLMNO
PQRST
UVWKY
"""

let transformTestDataCW1 = """
UPKFA
VQLGB
WRMHC
XSNID
YTOJE
"""

let transformTestDataCW2 = """
YXWVU
TSRQP
ONLMK
JIHGF
EDCBA
"""
let transformTestDataCW3 = """
EJOTY
DINSX
CHMRW
BGLQV
AFKPU
"""

var transformTestDataCCW1:String {
    transformTestDataCW3
}

var transposeTestDataCCW2:String {
    transformTestDataCW2
}

var transposeTestDataCCW3:String {
    transformTestDataCW1
}