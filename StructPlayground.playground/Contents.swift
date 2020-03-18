import Cocoa

enum Color:String {
    case RED = "#FF0000"
    case WHITE = "#FFFFFF"
    case BLACK = "#000000"
    case BLUE = "#0000FF"
    case GREEN = "#00FF00"
}

protocol DoesMove {
    var speed: Double {get set}
    func calcMaxSpeed() -> Double
}

class Car: DoesMove {
    var model: String
    var color: Color
    var numDoors: Int
    
    var speed: Double
    
    convenience init() {
        self.init(model: "", color: Color.BLACK, numDoors: 4, speed: 60)
    }
    
    init(model: String, color: Color, numDoors: Int, speed: Double){
        self.model = model
        self.color = color
        self.numDoors = numDoors
        self.speed = speed
    }
    
    func calcMaxSpeed() -> Double {
        switch self.model {
        case "Honda":
            return 60
        case "Ferrari":
            return 200
        default:
            return 100
        }
    }
}

class Horse: DoesMove {
    var name: String
    var isDomesticated: Bool
    var speed: Double
    
    convenience init(){
        self.init(name: "", isDomesticated: true, speed: 60)
    }
    
    init(name: String, isDomesticated: Bool, speed: Double) {
        self.name = name
        self.isDomesticated = isDomesticated
        self.speed = speed
    }
    
    func calcMaxSpeed() -> Double {
        if self.isDomesticated {
            return self.speed
        }
        return self.speed * 2.0

    }
}

class Computer: DoesMove {
    var name: String = ""
    var color: Color = Color.BLACK
    var speed: Double = 0.0
    
    func calcMaxSpeed() -> Double {
        return 0.0
    }
    
    
}

//
//class Student {
//    var name: String
//
//    init() {
//        self.name = ""
//    }
//
//}
//
//struct College {
//    var name: String
//
//    init() {
//        self.name = ""
//    }
//}
//
//var s1: Student = Student()
//var c1: College = College()
//
//func changeStudent(student: Student) {
//    student.name = "hello"
//}
//
//func changeStruct(college: College) {
//    college.name = "hello"
//}
//
//changeStudent(student: s1)
//changeStruct(college: c1)
//print(s1.name)
//print(c1.name)

struct College {
    var  name:String = ""
    init(name:String){
        self.name = name;
    }
}

var c1:College = College(name:"George Brown")
print(c1.name)

var c2:College = c1
print(c2.name)

var c3:College = c1

c1.name = "Jenelle College"
print(c1.name)
print(c2.name)

c3.name = "IT University"
print(c1.name)



func isPerfect(number num:Int) -> Bool {
    var total = num
    for i in 1..<num {
        if(num % i == 0) {
            total -= i
        }
    }
    
    return total == 0
}

print(isPerfect(number: 6))
print(isPerfect(number: 24))
