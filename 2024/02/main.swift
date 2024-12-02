print("Hello Brand New Day 2")


let reports = makeData(input:realData)

func makeData(input:String) -> ([[Int]]) {
    input.split(separator: "\n")
         .map { line in
            line.split(separator: " ")
                .map { Int($0)! }
              }
}

func withinJump(_ lhs:Int, _ rhs:Int) -> Bool  { !(abs(lhs-rhs) > 3)}
func validUp(_ lhs:Int, _ rhs:Int) -> Bool  {!(lhs >= rhs) && withinJump(lhs, rhs)  }
func validDown(_ lhs:Int, _ rhs:Int) -> Bool  {!(lhs <= rhs) && withinJump(lhs, rhs)}



// --- Part: 1

let validCount1 = reports.map { $0.matchesSort(using:validUp) || ($0.matchesSort(using:validDown)) }.count(where: { $0 })
print("Part 1:" , validCount1)

// --- Part: 2

func isCleanSlope(_ array:[Int], _ directionCheck: (Int, Int) -> Bool) -> Bool {

    let result = array.matchesSortWithReporting(using:directionCheck)
    //return true
    if result.0 { return true } 

    else {
        //TODO: only recheck area?
        for badseed in result.1 {
            if result.1.count == 1 && (badseed == array.endIndex || badseed == 0) { print("because at an end"); return true }
            var newArray = array
            newArray.remove(at: badseed)
            let patchCheckResult = newArray.matchesSort(using:directionCheck)
            if patchCheckResult { return true }
        }
        return false
    }

}

let validCount2 = reports.map { isCleanSlope($0, validUp) || isCleanSlope($0, validDown) }.count(where: { $0})
print("Part 2:" , validCount2)

