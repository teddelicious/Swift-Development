//
//  main.swift
//  sampleCode
//
//  Created by John Lin on 2020-02-19.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

/*
 1. Develop a Swift Program that prompts the user to enter two integer numbers,
 calculate the sum of the two numbers and then display the following :
 The two numbers entered
 The sum of the two numbers
 */
func getSumTwoNumber() -> Void {
    var num1, num2: Int
    
    print("Please enter a number: ")
    num1 = Int(readLine()!)!
    print("Please enter a second numnber: ")
    num2 = Int(readLine()!)!
    
    print("The numbers entered: \(num1), \(num2)")
    print("Sum of the two numbers is: \(num1 + num2)")
}
//getSumTwoNumber()

/*
 2. Develop a Swift Program that calculates the perimeter of a rectangle.
 */
func getPerimeterOfRectangle(width:Double, height:Double) -> Double {
    return 2*width + 2*height
}
//print(getPerimeterOfRectangle(width: 10, height: 5))

/*
 3. Develop a Swift Program that calculates an hourly paid worker gross salary and net salary.
 You are to assume that employees in this fictional scenario are paid per month.
 */
func calculateSalary(hrRate:Double) -> Double {
    let hoursPerWeek = 40.0
    let weekCount = 52/12.0
    return hrRate * hoursPerWeek * weekCount
}

//print(calculateSalary(hrRate: 15))

/*
 4. Develop a Swift Program which requests a price of an item, item number,
 item title and a discount percent from the user which should represent
 the percentage that would be discounted from the item.
 The program should then display the following :
    Original price of the item
    The discounted amount
    The amount the customer must pay.
 */

func item() -> Void {
    print("please enter item title")
    let itemTitle = readLine()!
    print("please enter item number")
    let itemNumber = Int(readLine()!)!
    print("please enter price of the item")
    let price = Double(readLine()!)!
    print("please enter discount percent")
    let discountPercentage = Double(readLine()!)!
    
    print("Item: \(itemTitle) - \(itemNumber) \n" +
        "Price: \(price) \n" +
        "Discounted amount: \(price * discountPercentage / 100.00) \n" +
        "Total: \(price * (1 - discountPercentage / 100.00))")
}

//item()

/*
 5. A computer repair shop charges $100 per hour for labour plus the cost of any parts used in the repair.
However, the minimum charge for any job is $150. Develop a program that will
 prompt the user for the number of hours worked and the cost of parts
 (which can be $0) and then print the charge for the job.
 */

func calcRepair() -> Double {
    let minimumCharge = 150.00
    let ratePerHour = 100.00
    print("Please enter the number of hours: ")
    let hours = Double(readLine()!)!
    print("Please enter the cost for the parts: ")
    let partsCost = Double(readLine()!)!
    let total = partsCost + hours * ratePerHour
    
    if total < minimumCharge {
        return minimumCharge
    }
    return total
}
//print("The cost for the repair is $\(String(format: "%.2f", calcRepair()))")

/*
 6. Develop a program that will prompt the user to enter a number and then display if the number is a positive or negative number.
*/

func checkSign(number:Double) -> Void {
    if number > 0 {
        print("Positive number")
    }else if number < 0{
        print("Negative number")
    }else{
        print("Number is 0")
    }
}

//print("Enter a number: ")
//let number = Double(readLine()!)!
//checkSign(number:number)

/*
 11. Develop a program that will output the seven times table you must use a for loop, as follows:
 1 x 7 = 7
 2 x 7 = 14
 3 x 7 = 21 . . .

 */

func sevenTimesTable(max:Int) -> Void {
    for i:Int in 1...(max){
        print("\(i) x \(7) = \(i*7)")
    }
}

//sevenTimesTable(max: 10)


/*
 13. Develop a program that will display to the screen the first 20 numbers, with their squares and cubes, as follows:
 */

func squaresAndCubes() -> Void {
    let max = 20
    for i:Int in 1...max{
        print("\(i) \t \(i*i) \t \(i*i*i)")
    }
}

//squaresAndCubes()

/*
 14. Develop a program to read 6 numbers and find the average of all odd numbers.
 */

func calcAvgOddNumbers() -> Double {
    let max = 6
    var total:Int = 0
    var count:Int = 0
    for i:Int in 1...max{
        print("Enter the \(i) number")
        var temp = Int(readLine()!)!
        if (temp % 2 != 0){
            total += temp
            count += 1
        }
    }
    
    if (count > 0){
        return Double(total) / Double(count)
    }
    return 0.0
}

//print(calcAvgOddNumbers())

/*
 Develop a program to read two pairs of integers. Each pair represents a fraction.
 For example, the pair 3 5 represents the fraction 3/5.
 Your program should print the sum of the given fractions.
 For example, give the pairs 3 5 and 2  3 your program should print 19/15.
 */

func calcFractions() -> Void {
    print("please enter the first fraction pair")
    let pair1 = (Int(readLine()!)!, Int(readLine()!)!)
    print("please enter the second fraction pair")
    let pair2 = (Int(readLine()!)!, Int(readLine()!)!)
    
    let numerator = pair1.0 * pair2.1 + pair2.0 * pair1.1
    let denominator = pair1.1 * pair2.1
    let wholeNumber = numerator / denominator
    let remainder = numerator % denominator
    wholeNumber > 0 ? print("the fraction is \(wholeNumber) \(remainder)/\(denominator)") : print("the fraction is \(remainder) / \(denominator)")
}
