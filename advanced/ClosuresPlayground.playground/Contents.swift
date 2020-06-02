import Cocoa


//Write a closure that prints the string "stuff" and assign the closure to a variable. Then call the closure.
let printStuff = {
    print("stuff")
}
printStuff()

//Write a closure that takes two integers and returns the sum of the integers. Assign the closure to a variable and then call the closure. The closure can be written in a few different ways. Experiment!
let sum: (Int, Int) -> Int = {
    return $0 + $1
}
print(sum(1, 2))

//Write a closure that returns the value 1337, without assigning the closure to a variable. Immediately call the closure and also ignore the return value from the closure.
_ = {
return 1337
}()

//Write a closure that returns the square of its input value. Write the whole closure and call it within the parentheses of a print call, i.e. print( <write your closure here> ).
print({
    (val: Int) -> Int in
    return val * val
}(5))

//Sort the array using closure:
let numbers = [16, 8, 15, 42, 4, 23]
numbers.sorted(by: {
    (x, y) in
    return x < y
})

//Write a function that takes a closure as input and calls that closure.
func callClosure(c: () -> ()) {
    c()
}
callClosure {
    print("closure is called")
}

//Write a function that returns a closure. The function should contain the following variable:
//let stuff = "This is stuff"
//The closure that the function returns should print the value of that variable.

func returnClosure() -> () -> Void {
    let stuff = "This is stuff"
    return {print(stuff)}
}
returnClosure()()
