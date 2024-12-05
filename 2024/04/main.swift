print("Hello Brand New Day 4")



let rows:[String] = makeRowData(input: test1)


func makeRowData(input:String) -> [String] {
    Array(input.split(separator: "\n").map { String($0) })
}


//MARK: --- Part: 1

let result = findXMAS(input:rows)

func findXMAS(input:[String]) -> Int {
    let width = input[0].count
    let height = input.count
    var runningTotal = 0
        for y in 0..<height {
        for x in 0..<width {
            let element = input[y][x]
            if element == "X" {
                //possible start
                let myLoc = GridPoint(x,y)
                let mNeighbors = validNeighbors(startPoint: myLoc, in: input, matches: "M")
                let aNeighbors = validSubNeighbors(startSet: mNeighbors, in: input, matches: "A")
                let sNeighbors = validSubNeighbors(startSet: aNeighbors, in: input, matches: "S")
                //print(myLoc, sNeighbors.count)
                runningTotal += sNeighbors.count
            }
            //elementDiags[x+y].append(input[y][x])
        }
    }
    return runningTotal

}

    func validNeighbors(startPoint:GridPoint, in input:[String], matches match:String.Element) -> [String:GridPoint] {
        let width = input[0].count
        let height = input.count
        return startPoint.labeledNeighbors(maxX:width-1, maxY:height-1)
        .filter{ 
                    let x = $0.value.x 
                    let y = $0.value.y 
                    return input[y][x] == match
                }     
    }

    func validSubNeighbors(startSet:[String:GridPoint], in input:[String], matches match:String.Element) -> [String:GridPoint] {
        let width = input[0].count
        let height = input.count
        var valid:[String:GridPoint] = [:]
        for item in startSet {
            //print(item)
            let point = item.value
            let possible = point.labeledNeighbors(maxX:width-1, maxY:height-1)
            if let nextPoint = possible[item.key] {
                    if input[nextPoint.y][nextPoint.x] == match {
                        valid[item.key] = nextPoint
                    }
            }
        }
        return valid
    }



let p1 = result
// -----------------------------------------------------------------------------
print("Part 1:" , p1)
// print(cols)
// print(diags)
// -----------------------------------------------------------------------------

// --- Part: 2

let result2 = findMASMAS(input:rows)

func findMASMAS(input:[String]) -> Int {
    let width = input[0].count
    let height = input.count
    var runningTotal = 0
        for y in 0..<height {
        for x in 0..<width {
            let element = input[y][x]
            if element == "A" {
                //possible start
                let myLoc:GridPoint = GridPoint(x,y)
                let vN:[String:GridPoint] = myLoc.labeledNeighbors(maxX:width-1, maxY:height-1)
                let set1:Set<Character> = Set([vN["tl"], vN["br"]].compactMap { $0 }.map { input[$0.y][$0.x] })
                let set2:Set<Character> = Set([vN["bl"], vN["tr"]].compactMap { $0 }.map { input[$0.y][$0.x] })
                //var valid:Bool = false
                if set1 == set2 && set2 == Set<Character>(["M", "S"]) {
                    runningTotal += 1
                    //valid = true
                }
                //print(set1, set2, valid)

            }
            //elementDiags[x+y].append(input[y][x])
        }
    }
    return runningTotal

}

let p2 = result2
// -----------------------------------------------------------------------------
print("Part 2:" , p2)
// -----------------------------------------------------------------------------

//MARK: --- After Party
//Note: I actually did this way first, but flubbed doing 2 passes for the regex
//and rerouted to search pattern. 

let p3 =  otherWay()
// -----------------------------------------------------------------------------
print("AfterParty:" , p3)
// -----------------------------------------------------------------------------


func otherWay() -> Int {
    //The first way fixed
    func makeRowData(input:String) -> [[String.Element]] {
        input.split(separator: "\n").map { Array($0) }
    }

    func makeColumns(input:[[String.Element]]) -> [[String.Element]] {
        input
            .rotatingCCW()
    }

    //MARK: --- Part: 1


    let rows = makeRowData(input: test1)
    let cols = makeColumns(input: rows)
    let diagsOnRows = makeDiagonals(input: rows)
    let diagsOnCols = makeDiagonals(input: cols)

    // print(rows)
    // print(cols)
    // print(diagsOnRows)
    // print(diagsOnCols)

    //TODO: alternatively, don't mush them together, async let each of them
    //to then run them in parallel 
    var allSets = rows
    allSets.append(contentsOf: cols)
    allSets.append(contentsOf: diagsOnRows)
    allSets.append(contentsOf: diagsOnCols)
    //print(allSets.count, rows.count + cols.count)

    let keywords = ["XMAS", "SAMX"]
    let smallestWord = keywords.map { $0.count }.min()!
    //TODO - make pattern / keyword?
    let pattern1  = #/(?<xmas>XMAS)/#
    let pattern2 = #/(?<smax>SAMX)/#
    let result = allSets.filter { $0.count >= smallestWord }
                            .map { String($0) }
                            .map { string in
                                    var count = string.matches(of: pattern1).count
                                    count += string.matches(of: pattern2).count
                                    //print(string,count)
                                    return count
                                }.reduce(0,+)

    return result
}
