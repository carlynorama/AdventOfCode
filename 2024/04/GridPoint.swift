//
//  Coords.swift
//  AdventOfCode2022
//
//  Created by Carlyn Maw on 12/8/22.
//  

import Foundation

// public struct Coord:Hashable {
//     public let location:GridPoint
//     public let bearing:Direction
// }

// public extension Coord {
//     init(_ l:GridPoint, _ b:Direction) {
//         self.location = l
//         self.bearing = b
//     }
// }



public struct GridPoint:Hashable {
    public let x:Int
    public let y:Int
}

public extension GridPoint {
    init(_ x:Int, _ y:Int) {
        self.x = x
        self.y = y
    }
    
}

public extension GridPoint {
    //X: 0 -> Max , Y: 0 -> Max
    init(index:Int, rowWidth:Int) {
        self.x = index % rowWidth
        self.y = index / rowWidth
    }
}

extension GridPoint:Comparable {
    public static func < (lhs: GridPoint, rhs: GridPoint) -> Bool {
        if lhs.y == rhs.y { return lhs.x < rhs.x }
        return  lhs.y < rhs.y
    }
}

public extension GridPoint {
    static func mdistance(sx:Int, sy:Int, bx: Int, by:Int) -> UInt {
        (sx-bx).magnitude + (sy-by).magnitude
    }
    
    func mdistance(to other:GridPoint) -> UInt {
        Self.mdistance(sx: self.x, sy: self.y, bx: other.x, by: other.y)
    }
}

public extension GridPoint {
    //Assumes 0,0 top left.
    // func move(direction:Direction) -> Self {
    //     switch direction {
    //     case .up: return Self(self.x, self.y - 1)
    //     case .down: return Self(self.x, self.y + 1)
    //     case .left: return Self(self.x - 1 , self.y)
    //     case .right: return Self(self.x + 1 , self.y)
    //     }
    // }
    
//    func isNeighbor(to b:Self) -> Bool {
//        let a = self
//        if (a.x-b.x).magnitude > 1 { print("Not Neighbor (\(a.x),\(a.y)), (\(b.x),\(b.y))") ; return false }
//        if (a.y-b.y).magnitude > 1 { print("Not Neighbor (\(a.x),\(a.y)), (\(b.x),\(b.y))") ; return false }
//        print("Neighbor (\(a.x),\(a.y)), (\(b.x),\(b.y))") ;
//        return true
//    }
    
func isNeighbor(to b:Self) -> Bool {
        let a = self
        if (a.x-b.x).magnitude > 1 { return false }
        if (a.y-b.y).magnitude > 1 { return false }
        return true
    }
    
    //WHY NOT?
    var debugDescription:String {
        "(\(self.x),\(self.y))"
    }
}

public extension GridPoint {
    static func prettyPrintArray(_ array:[GridPoint]) {
        print("[", terminator: "")
        array.dropLast().forEach { item in
            print("(\(item.x), \(item.y))", terminator: ", ")
        }
        let last = array.last!
        print("(\(last.x), \(last.y))", terminator: "")
        print("]")
    }
    
    var pretty:String {
        "(\(x), \(y))"
    }
}

public extension GridPoint {
    var tl:Self { Self(self.x-1, self.y-1) }
    var tm:Self { Self(self.x, self.y-1) }
    var tr:Self { Self(self.x+1, self.y-1) }
    var ml:Self { Self(self.x-1, self.y) }
    var mr:Self { Self(self.x+1, self.y) }
    var bl:Self { Self(self.x-1, self.y+1) }
    var bm:Self { Self(self.x, self.y+1) }
    var br:Self { Self(self.x+1, self.y+1) }

    func neighbors(minX:Int = 0, minY:Int = 0, maxX:Int, maxY:Int) -> [Self] {
        var candidates:[Self] = []
        let doLeft = self.x > minX
        let doRight = self.x < maxX
        if self.y > minY {
            if doLeft { candidates.append(tl)}
            candidates.append(tm)
            if doRight { candidates.append(tr)}
        }
        if doLeft { candidates.append(ml) }
        if doRight { candidates.append(mr) }
        if self.y < maxY {
            if doLeft { candidates.append(bl)}
            candidates.append(bm)
            if doRight { candidates.append(br)}
        }
        return candidates
    }

    func labeledNeighbors(minX:Int = 0, minY:Int = 0, maxX:Int, maxY:Int) -> Dictionary<String,Self>  {
        var candidates:Dictionary<String,Self> = [:]
        let doLeft = self.x > minX
        let doRight = self.x < maxX
        if self.y > minY {
            if doLeft { candidates["tl"]=tl }
            candidates["tm"]=tm
            if doRight { candidates["tr"]=tr }
        }
        if doLeft { candidates["ml"]=ml }
        if doRight { candidates["mr"]=mr }
        if self.y < maxY {
            if doLeft { candidates["bl"]=bl}
            candidates["bm"]=bm
            if doRight { candidates["br"]=br }
        }
        return candidates
    }

    func compassNeighbors(minX:Int, maxX:Int, minY:Int, maxY:Int) -> [Self] {
        var candidates:[Self] = []
        let doLeft = self.x > minX
        let doRight = self.x < maxX
        if self.y > minY {
            candidates.append(tm)
        }
        if doLeft { candidates.append(ml) }
        if doRight { candidates.append(mr) }
        if self.y < maxY {
            candidates.append(bm)
        }
        return candidates
    }

    func convertToIndex(width:Int, rowSeparatorCount:Int) -> Int {
        self.y * (width + rowSeparatorCount) + self.x
    }
    
    func containedIn(minX:Int = 0, maxX:Int, minY:Int = 0, maxY:Int) -> Bool {
        self.x >= minX && self.x <= maxX && self.y >= minY && self.y <= maxY
    }

    func allNeighbors() -> [Self] {
        [tl, tm, tr, ml, mr, bl, bm, br]
    }
}

public extension GridPoint {
    static func bounds(from points:[GridPoint]) -> (minX:Int, minY:Int, maxX:Int, maxY:Int) {
        let minX = points.min(by: { $0.x  < $1.x })?.x
        let maxX = points.max(by: { $0.x  < $1.x })?.x

        let minY = points.min(by: { $0.y  < $1.y })?.y
        let maxY = points.max(by: { $0.y  < $1.y })?.y
        
        // print("X range:", minX!, maxX!)
        // print("Y range:", minY!, maxY!)

        return (minX!, minY!, maxX!, maxY!)
    }
}
