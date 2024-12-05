print("Hello Brand New Day 5")


let (rules, thingsToPrint) = makeData(input:test1)

func makeData(input:String) -> (rules:[[String.SubSequence]], data:[[String.SubSequence]] ) {
    let twoPieces = input.split(separator: "\n\n")
    assert(twoPieces.count == 2)
     let rules = twoPieces[0].split(separator: "\n").map { String($0).split(separator: "|")}.map { $0 }
     let data = twoPieces[1].split(separator: "\n").map { String($0).split(separator: ",")}.map { $0 }
    return (rules, data)
}

var rulesDictionary = Dictionary<Int,[Int]>()


struct Page {
    let value:Int
}
 extension Page:Comparable {
    init(_ string:some StringProtocol) {
        self.value = Int(string)!
    }
     static func < (lhs: Page, rhs: Page) -> Bool {
         if let pageInfo = rulesDictionary[lhs.value] {
            return pageInfo.contains(rhs.value)
         } 
         return false
     }
 }

 struct Booklet {
    let pages:[Page]

    var count:Int {
        pages.count
    }

    var midIndexValue:Int {
        //let index = Int(((Double(pages.count))/2.0).rounded())-1
        let index = pages.count/2 //rounds down, that's actually good here. 
        return pages[index].value
    }
 }



 extension Booklet {
    init(_ p:[some StringProtocol]) {
        self.pages = p.map { Page($0) }
    }

    func verifyBooklet() -> Bool {
        //tried to write a first(where: fails check) version but had trouble with
        //the using the next index. fix was way more overkill than just using
        //the for loop
        let lastIndex = pages.count-1
        for (index, page) in pages.enumerated() {
            if index == lastIndex { continue }
            if page <= pages[index+1] { continue }
            else { return false }
        }
        return true

    }

    func sorted() -> Booklet {
        Booklet(pages: pages.sorted())
    }
 }

//MARK: --- Part: 1

for rule in rules {
    let key = Int(rule[0])!
    let value = Int(rule[1])!

    if var currentValue = rulesDictionary[key] {
        currentValue.append(value)
        rulesDictionary[key] = currentValue
    } else {
        rulesDictionary[key] = [value]
    }
}

let booklets = thingsToPrint.map { Booklet($0) }

let checked1 = booklets.filter { $0.verifyBooklet() }//.map { $0.pages.map { $0.value } }
let sum = checked1.map { $0.midIndexValue }.reduce(0,+)

let p1 = sum
// -----------------------------------------------------------------------------
print("Part 1:" , p1)
// -----------------------------------------------------------------------------

//MARK: --- Part: 2

let failedSum = booklets.filter { !$0.verifyBooklet() }.map { $0.sorted() }.map { $0.midIndexValue }.reduce(0,+)


let p2 = failedSum
// -----------------------------------------------------------------------------
print("Part 2:" , p2)
// -----------------------------------------------------------------------------