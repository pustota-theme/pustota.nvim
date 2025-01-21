namespace MyTest

open System

// A custom measure type
[<Measure>]
type cm

// Union type
type Shape = 
    | Circle of radius: float
    | Rectangle of width: float * height: float

// Record type
type Person = {
    Name: string
    Age: int
}

// Generic class with mutable state
type MyClass<'T>(initialValue: 'T) =
    let mutable value = initialValue

    member this.Value
        with get () = value
        and set(v) = value <- v
    
    member this.ComputeSomething(f: 'T -> 'T) =
        value <- f value

// Module containing various functions and values
module Utilities =
    // Simple function (will be partially applied later)
    let add x y = x + y

    // Recursive function
    let rec factorial n =
        if n <= 1 then 1 
        else n * factorial (n - 1)

    // Pattern matching on a union
    let describeShape shape =
        match shape with
        | Circle r -> sprintf "A circle of radius %f" r
        | Rectangle(w, h) ->
            sprintf "A rectangle of width %f and height %f" w h

    // List comprehension
    let squares = [ for i in 1..10 -> i * i ]

    // Array
    let arr = [| 1; 2; 3; 4 |]

    // Asynchronous workflow
    let asyncWork = async {
        do! Async.Sleep 100
        return 42
    }
    
    // Pattern matching on an option
    let checkOption opt =
        match opt with
        | Some v -> sprintf "Value: %d" v
        | None -> "No value"

    // Active pattern for even/odd checking
    let (|Even|Odd|) x =
        if x % 2 = 0 then Even else Odd

    let testEvenOdd x =
        match x with
        | Even -> "It's even"
        | Odd -> "It's odd"

    // Function composition examples
    let double x = x * 2
    let increment x = x + 1
    let doubleThenIncrement = double >> increment
    let incrementThenDouble = increment >> double

    // Interface and object expression
    type IPrintable =
        abstract member Print : unit -> unit

    let printableObj =
        { new IPrintable with
            member __.Print() =
                printfn "Hello from IPrintable object expression" }

    // Using the custom measure type
    let length : float<cm> = 10.0<cm>

    // Partial application
    let addFive = add 5

// Entry point module
module Main =
    [<EntryPoint>]
    let main argv =
        // Working with union types
        let shape1 = Circle 10.0
        let shape2 = Rectangle(5.0, 10.0)
        printfn "%s" (Utilities.describeShape shape1)
        printfn "%s" (Utilities.describeShape shape2)

        // Calling a recursive function
        printfn "Factorial of 5 is %d" (Utilities.factorial 5)

        // Using a generic class
        let c = MyClass(10)
        c.ComputeSomething(Utilities.doubleThenIncrement)
        printfn "MyClass value after compute: %d" c.Value

        // Testing active pattern matching
        let evenTest = Utilities.testEvenOdd 18
        let oddTest = Utilities.testEvenOdd 9
        printfn "18 -> %s, 9 -> %s" evenTest oddTest

        // Running an async workflow
        let runAsync = Utilities.asyncWork |> Async.RunSynchronously
        printfn "Async result: %d" runAsync

        // Using a record
        let person = { Name = "John"; Age = 30 }
        printfn "Hello, %s, age %d" person.Name person.Age

        // Object expression
        Utilities.printableObj.Print()

        // Partial application
        let partialResult = Utilities.addFive 10
        printfn "Partially applied: %d" partialResult
