import Foundation

let arrays = makeData(input: test1)

let arrayLeft = arrays.left.sorted()
let arrayRight = arrays.right.sorted()
//print(arrayLeft)
//print(arrayRight)

func makeData(input:String) -> (left:[Int], right:[Int]) {
    let lines = input.split(separator: "\n")
    var left:[Int] = []
    var right:[Int] = []
    for line in lines {
    let split = line.split(separator: "   ")
       left.append(Int(split[0])!)
       right.append(Int(split[1])!)
    }
    return (left, right)
}

// -- Part 1

let zipped = zip(arrayLeft, arrayRight)

let distance = zipped.reduce(0, { (total, items) in
    total + abs(items.0-items.1)
})

// -----------------------------------------------------------------------------
print("Part 1: \(distance)")
// -----------------------------------------------------------------------------

//MARK: Part 2
let setLeft = Set(arrayLeft)
let setRight = Set(arrayRight)
let mutuals = Array(setLeft.intersection(setRight)).sorted()
//print(mutuals)

var similarity = 0
//TODO iterate over arrays only once using that the array is sorted.
for item in mutuals {
    let fl = Int(arrayLeft.firstIndex(of: item)!)
    let ll = Int(arrayLeft.lastIndex(of: item)!)
    
    let itemCountLeft = ll - fl + 1
    //slow way if not already sorted
    //let count2 = arrayLeft.count { $0 == item }
    
    let fr = Int(arrayRight.firstIndex(of: item)!)
    let lr = Int(arrayRight.lastIndex(of: item)!) 
    let itemCountRight = lr - fr + 1

    //print("item \(item) - left:\(itemCountLeft), right:\(itemCountRight)")
    let similarityContribution = itemCountLeft * (item * itemCountRight)
    //print(similarityContribution)
    similarity += similarityContribution

}

var dictionary:Dictionary<Int, Int> = [:] 

for item in mutuals {
    dictionary[item] = 0
}

for item in arrayRight {
    if dictionary.keys.contains(item) {
        dictionary[item] = dictionary[item]! + 1
    }
}
//print(dictionary)

// -----------------------------------------------------------------------------
print("Part 2: \(similarity)")
// -----------------------------------------------------------------------------



