//https://github.com/swiftlang/swift/blob/4ac0bfd8e2ef94252a1705e09fdcaf22bb2cecf6/stdlib/public/core/Sort.swift#L270


extension Array {

    //TODO: all of these should throw if range is too small. 
    func matchesSort(using checkFunction: (Self.Element, Self.Element) throws -> Bool) rethrows -> Bool {
        let range = (self.startIndex...self.endIndex)
        //TODO: Handle
        precondition(range.lowerBound != range.upperBound)
        var checkEnd = range.lowerBound + 1
        
        repeat {
            let i = checkEnd
            let j = index(before: i)
            if try !checkFunction(self[j], self[i]) { return false }
            formIndex(after: &checkEnd)
        } while checkEnd < range.upperBound
        return true
    }

    func matchesSortWithReporting(using checkFunction: (Self.Element, Self.Element) throws -> Bool) rethrows -> (Bool,Set<Index>) {
        let range = (self.startIndex...self.endIndex)
        precondition(range.lowerBound != range.upperBound)
        var checkEnd = range.lowerBound + 1
        var faults:Set<Index> = []
        repeat {
            let i = checkEnd
            let j = index(before: i)
            if try !checkFunction(self[j], self[i]) {
                faults.insert(j); faults.insert(i)
            }
            formIndex(after: &checkEnd)
        } while checkEnd < range.upperBound
        return (faults.isEmpty, faults)
    }
}