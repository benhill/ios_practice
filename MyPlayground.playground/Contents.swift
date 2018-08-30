import UIKit

var myInt: Int?
var myInt2: Int?
var myInt3: Int?
var error: String
myInt = 667
myInt2 = 1
myInt3 = 1

if let i1 = myInt,
    let i2 = myInt2,
    let i3 = myInt3
{
    i1 / i2 / i3
} else {
    error = "oops"
}


let nameByParkingSpace = [13: "Alice", 27: "Bob", 65: "Joe"]

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
}

enum PieType: Int{
    case apple = 0
    case peach
    case coconut
}

let pieRawValue = PieType.coconut.rawValue

if let pieType = PieType(rawValue: pieRawValue) {
    
}


