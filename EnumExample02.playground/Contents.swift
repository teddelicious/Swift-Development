//: Playground - noun: a place where people can play

import UIKit

enum Days {
    case MON, TUE, WED, THU, FRI, SAT, SUN
}

// Example 2 - Assigning an enum to have default values
// Every value must be UNIQUE!
enum ImportantRooms:String{
    case C465 = "Mac Lab classroom"
    case C467 = "Information Technology Department"
    case C317 = "Student Services"
    case E435 = "Monday's Lecture Room"
    case ATRIUM = "Tim Hortons"
}

// Example 3: Use the enum to represent the "location" of a student
// By default, all students are located in C465
class Student {
    var name:String=""
    var location:ImportantRooms = ImportantRooms.C465
    
    init(){}
}

// By default, all students start in C465
var peter = Student()           // peter is in C465

// Michelle also starts in C465
var michelle = Student()        // by default, michelle starts in C465

// But sometimes students get hungry and want to go to Timmies
michelle.location = ImportantRooms.ATRIUM

// Alex is a student who works part time at the Student Services office.
// On Mondays, he has lecture
// On other days, he works at the office

var alex = Student()            // alex starts in C465
let currentDay = Days.MON       // set today's date

// alex's location changes based on the day
if (currentDay == Days.MON) {
    alex.location = ImportantRooms.E435
}
else {
    alex.location = ImportantRooms.C317
}

// Display where the student are
print("WHERE ARE THE STUDENTS?")
print("Peter is in: \(peter.location)")
print("Michelle is in: \(michelle.location)")
print("Alex is in: \(alex.location)")

print("\n\n")

// Get the "full name" of the student's location
print("WHERE ARE THEY? (PART 2)")
print("Peter is in: \(peter.location.rawValue)")
print("Michelle is in: \(michelle.location.rawValue)")
print("Alex is in: \(alex.location.rawValue)")

