import UIKit

var str = "Hello, playground"

//Mark: String Literals

//let literal = """
//    This string is preformatted
//Yay
//"""
//
//print(literal)

//Mark: Raw Strings
//let raw = #" I don't want to go to "class" I want to sleep"#
//
//print(raw)
//
//let unreadMessage = 3
//
//let rawInter = #"You have \#(unreadMessage) unread messges"#
//
//print(rawInter)
//
//let names = "Ariel, Danny, Aileen, David"
//let aileenRegex = "\\bAileen\\b"
//let aileenRegEx = #"\bAileen\b"#
//
//let aileenRange = names.range(of: aileenRegEx, options: .regularExpression)
//print(names[aileenRange!])

let rawLiteral = #"""
    Raw
Literal
!
"""#


// MARK: Boolean Toggle
//var boolean: Bool = false
//print(boolean)
//
//boolean.toggle()
//
//print(boolean)
//

//MARK: Custom String Interpolation
//struct MenuItem {
//    var name: String
//    var price: Double
//}
//
//let coffee = MenuItem(name: "Coffee", price: 3.00)
//let tea = MenuItem(name: "Tea", price: 2.55)
//
//print("""
//    Beverages:
//    \(coffee)
//    \(tea)
//""")
//
//extension String.StringInterpolation {
//    mutating func appendInterpolation(_ value: MenuItem) {
//        appendLiteral("\(value.name)...........$\(value.price)")
//    }
//}

//MARK: Optionals
var score: Int?
//print(score)
//
//score = 80
//
//print(score!)
//
//if score != nil {
//    print(score!)
//}

// Optional binding
//if let currentScore = score {
//    print(currentScore)
//}
//
//let myScore = score ?? 0
//print(myScore)

//MARK: Optional Chaining
//struct Developer {
//    var name: String
//    var app: App?
//}
//
//struct App {
//    var title: String
//}
//
//let chad = Developer(name: "Chad", app: App(title: "Not First"))
//
//if let app = chad.app?.title {
//    print(app)
//}
//else {
//    print("This developer has no apps.")
//}

// MARK: Custom Type Casting

//class Commuter {
//    var efficiency: Int
//    init(efficiency: Int) {
//        self.efficiency = efficiency
//    }
//}
//
//class Bike: Commuter {
//    var type: String
//    override init(efficiency: Int, type: String) {
//        self.type = type
//        super.init(efficiency: efficiency)
//    }
//}
//
//class Skates: Commuter {
//    var brand: String
//    override init(efficiency: Int, brand: String) {
//        self.brand = brand
//        super.init(efficiency: efficiency)
//    }
//}
//
//var myCommuters = [
//    Bike(efficiency: 8, type: "road"),
//    Bike(efficiency: 6, type: "mountain"),
//    Skates(efficiency: 4, brand: "RollerBlade"),
//    Skates(efficiency: 2, brand: "K2")
//]
//
//var bikeCount = 0
//var skatesCount = 0
//
//for commuter in myCommuters {
//    if commuter is Bike {
//        bikeCount += 1
//    }
//    if commuter is Skate {
//        skateCount += 1
//    }
//}
//
//for commuter in myCommuters {
//    if let myBike = commuter as? Bike {
//        print("Bike is a \(myBike.type) bike")
//    }
//    if let mySkates = commuter as? Skates {
//        print("Skate is a \(mySkates.type) skate")
//    }
//}


let roster = ["Evan", "eva", "Tommy", "Tom"]

//var reversedRoster = roster.sorted(by: {(s1: String, s2: String) -> Bool in
//    return s1 > s2
//})

//print(reversedRoster)

//var reversedRoster = roster.sorted(by: {s1, s2 in s1 > s2})

//var reversedRoster = roster.sorted(by: {$0 > $1})

var reversedRoster = roster.sorted(by: >)
print(reversedRoster)

// MARK: Enumerations
enum JobStatus {
    case NotStarted
    case InProgress
    case Done
}

struct Job {
    var title: String
    var status: JobStatus
}

var lab1 = Job(title: "Lab 1", status: JobStatus.NotStarted)

switch lab1.status {
case .Done:
    print("Good Job")
case .InProgress:
    print("I'm working on it")
case .NotStarted:
    print("Get to work")
}

// MARK: Errors
enum APIError: Error {
    case Forbidden
    case NotFound
    case RequestTimeout
    case UnknownResponse
}

func checkStatus(status: Int) throws -> String {
    switch status {
    case 403: throw APIError.Forbidden
    case 404: throw APIError.NotFound
    case 408: throw APIError.RequestTimeout
    case 200: return "OK"
    default:
        throw APIError.UnknownResponse
    }
}

//pretty good
do {
    let response = try checkStatus(status: 403)
    print(response)
} catch {
    print(error)
}

// better
do {
    let response = try checkStatus(status: 403)
    print(response)
} catch APIError.Forbidden {
    print("1")
    
} catch APIError.NotFound {
    print("2")
    
} catch APIError.RequestTimeout {
    print("3")
} catch APIError.UnknownResponse {
    print("4")
} catch {
    print(error)
}

// MARK: Guard or Early Exit
// Guards need to be inside of a function to work properly
//var dividend: Double = 3
//var divisor: Double = 2
//
//guard divisor != 0 else {
//    print("Cant divide by zero")
//    return 6
//}
//
//let result = dividend / divisor



