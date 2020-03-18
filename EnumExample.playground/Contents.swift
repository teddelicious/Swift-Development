//: Playground - noun: a place where people can play

import UIKit

enum Days {
    case MON, TUE, WED, THU, FRI, SAT, SUN
}

// Example 1: Outputting the value of an enum to the screen:
print(Days.MON)     // outputs MON
print(Days.SUN)     // outputs SUN


// Example 2: Creating a function with the Days enum
func isWeekend(day:Days) {
    if (day == Days.MON) {
        print("Weekday")
    }
    else if (day == Days.TUE) {
        print("Weekday")
    }
    else if (day == Days.WED) {
        print("Weekday")
    }
    else if (day == Days.SAT || day == Days.SUN) {
        print("weekend")
    }
}

// call the function and pass in saturday
isWeekend(day: Days.SAT) // Expected result = "weekend""


