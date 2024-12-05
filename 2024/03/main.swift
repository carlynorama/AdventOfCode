
import Foundation


print("Hello Brand New Day 3")

//MARK: --- Part: 1

//let findMul = /mul\(\d{1,3},\d{1,3}\)/
  
        let mulREgEx = #/mul\((\d{1,3}),(\d{1,3})\)/#


func sumFromData(input:String, pattern:Regex<(Substring, Substring, Substring)>) -> Int {
    let matches = input.matches(of:pattern)
    return matches.reduce(0, { partialResult, match in
        partialResult + (Int(match.1)! * Int(match.2)!)
    })

}

let p1 = sumFromData(input: test0, pattern: mulREgEx)
// -----------------------------------------------------------------------------
print("Part 1:" , p1)
// -----------------------------------------------------------------------------

//MARK: --- Part: 2

let withCommands = #/(?<mul>mul\((?<a>\d{1,3}),(?<b>\d{1,3})\))|(?<off>don't\(\))|(?<on>do\(\))/#

func controlledSumFromData(input:String, pattern:Regex<(Substring, mul:Substring?, a:Substring?, b:Substring?, off:Substring?, on:Substring?)>) -> Int {
    let matches = input.matches(of:pattern)
    var sum = 0
    var operateFlag:Bool = true
    for match in matches {
        //print(match.output)
        if match.output.on != nil { operateFlag = true } 
        else if match.output.off != nil { operateFlag = false } 
        else {
            if operateFlag && match.output.mul != nil {
                sum += Int(match.output.a!)! * Int(match.output.b!)!
            }
        } 
    }
    return sum
}

let p2 = controlledSumFromData(input: test4, pattern: withCommands)
// -----------------------------------------------------------------------------
print("Part 2:" , p2)
// -----------------------------------------------------------------------------
