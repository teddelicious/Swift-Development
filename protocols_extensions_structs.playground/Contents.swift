import Cocoa

// protocols
protocol HasName {
    func getName() -> String
}

class People: HasName {
    var firstName: String
    var middleName: String?
    var lastName: String
    
    init(firstName: String, middleName: String?, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
    }
    
    func getName() -> String {
        var middle = " "
        if let x = middleName {
            middle = " \(x) "
        }
        return self.firstName + middle + lastName
    }
}

class Phone: HasName {
    var company: String
    var make: String
    var model: String
    
    init(company: String, make: String, model: String) {
        self.company = company
        self.make = make
        self.model = model
    }
    
    func getName() -> String {
        return self.company + " " + self.make + " " + self.model
    }
}

class OS: HasName {
    var company: String
    var osName: String
    var version: String
    
    init(company: String, osName: String, version: String) {
        self.company = company
        self.osName = osName
        self.version = version
    }
    
    func getName() -> String {
        return self.company + " " + self.osName + " " + self.version
    }
}

let people: People = People(firstName: "John", middleName: nil, lastName: "Lin")
let phone: Phone = Phone(company: "Oneplus", make: "Oneplus", model: "5")
let os: OS = OS(company: "Microsoft", osName: "Windows", version: "10")

let nameables: [HasName] = [people, phone, os]

//for nameable in nameables {
//    print(nameable.getName())
//}

//extensions
extension Int {
    func square() -> Int {
        return self * self
    }
    
    var isEven: Bool {
        return self % 2 == 0
    }
}

let int: Int = 99
print(int.square())
print(int.isEven)

extension String {
    
    func explode() -> String? {
        
        var result = ""
        
        for (index, char) in self.enumerated() {
            
            if index == 0 {
                
                result += "\(char)"
                
            }else {
                
                result += " \(char)"
                
            }
            
        }
        
        if result == "" {
            
            return nil
            
        }
        
        
        
        return result
        
    }
}
let str: String = "pineapple"
let str2: String = "M"
print(str.explode()!)
print(str2.explode()!)
print("".explode())


////enum
//enum Days: String {
//    case MON = "weekday"
//    case TUE = "weekday"
//    case WED = "weekday"
//    case THU = "weekday"
//    case FRI = "weekday"
//    case SAT = "weekend"
//    case SUN = "weekend"
//}
