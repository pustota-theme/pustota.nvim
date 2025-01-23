package main

import (
	"errors"
	"fmt"
	"math/rand"
	"reflect"
	"sync"
	"time"
)

//--------------------------------------------------------------------------------
// Constants and Variables
//--------------------------------------------------------------------------------
const (
	First = iota
	Second
	Third
)

var (
	GlobalVar = "I am a global variable."
)

//--------------------------------------------------------------------------------
// Custom error type
//--------------------------------------------------------------------------------
type MyError struct {
	Message string
	Code    int
}

func (e *MyError) Error() string {
	return fmt.Sprintf("MyError - code: %d, message: %s", e.Code, e.Message)
}

//--------------------------------------------------------------------------------
// Structs and Interfaces
//--------------------------------------------------------------------------------
type Embedded struct {
	Description string
}

type Person struct {
	Name  string
	Age   int
	Embed Embedded // struct embedding
}

type Greeter interface {
	Greet() string
}

// Greet implements the Greeter interface (value receiver).
func (p Person) Greet() string {
	return fmt.Sprintf("Hello, my name is %s. I am %d years old.", p.Name, p.Age)
}

// Pointer receiver: modifies the Person's age.
func (p *Person) HaveBirthday() {
	p.Age++
}

//--------------------------------------------------------------------------------
// Generics
//--------------------------------------------------------------------------------
// Generic function to find the minimum of two comparable values.
func Min[T comparable](a, b T) T {
	if a < b {
		return a
	}
	return b
}

//--------------------------------------------------------------------------------
// Helper functions
//--------------------------------------------------------------------------------
func causeError(shouldError bool) error {
	if shouldError {
		return &MyError{Message: "Something went wrong!", Code: 500}
	}
	return nil
}

func doPanicAndRecover() {
	defer func() {
		if r := recover(); r != nil {
			fmt.Println("Recovered from panic:", r)
		}
	}()
	panic("This is a forced panic!")
}

// Uses reflection to print the type of the argument.
func printType(value interface{}) {
	fmt.Println("Type is:", reflect.TypeOf(value))
}

// Named return values.
func randomInts() (first, second int) {
	rand.Seed(time.Now().UnixNano())
	first = rand.Intn(100)
	second = rand.Intn(100)
	return
}

//--------------------------------------------------------------------------------
// Concurrency example
//--------------------------------------------------------------------------------
func worker(id int, wg *sync.WaitGroup, ch <-chan string) {
	defer wg.Done()
	for msg := range ch {
		fmt.Printf("[Worker %d] Received message: %s\n", id, msg)
		time.Sleep(100 * time.Millisecond) // Simulate work
	}
}

//--------------------------------------------------------------------------------
// MAIN
//--------------------------------------------------------------------------------
func main() {
	fmt.Println("---------- Constants and Variables ----------")
	fmt.Println("First:", First, "Second:", Second, "Third:", Third)
	fmt.Println("GlobalVar:", GlobalVar)

	fmt.Println("\n---------- Struct and Interface ----------")
	p := Person{
		Name: "Alice",
		Age:  29,
		Embed: Embedded{
			Description: "An embedded struct example",
		},
	}
	fmt.Println(p.Greet())
	fmt.Println("Embedded Description:", p.Embed.Description)

	p.HaveBirthday()
	fmt.Printf("After birthday, %s is now %d.\n", p.Name, p.Age)

	var g Greeter = p
	fmt.Println("Greeter interface says:", g.Greet())

	fmt.Println("\n---------- Slices, Arrays, and Maps ----------")
	slice := []int{1, 2, 3}
	array := [3]string{"Go", "Rust", "Python"}
	myMap := map[string]int{
		"Alice": 25,
		"Bob":   30,
	}

	fmt.Println("slice:", slice)
	fmt.Println("array:", array)
	fmt.Println("myMap:", myMap)

	fmt.Println("\n---------- Error Handling and Custom Error ----------")
	if err := causeError(true); err != nil {
		fmt.Println("Error occurred:", err)
	} else {
		fmt.Println("No error triggered.")
	}

	fmt.Println("\n---------- Panic and Recover ----------")
	doPanicAndRecover()

	fmt.Println("\n---------- Reflection ----------")
	printType(123)
	printType("Hello")
	printType(p)

	fmt.Println("\n---------- Generics (Min) ----------")
	fmt.Println("Min of 5 and 10:", Min(5, 10))
	fmt.Println("Min of 3.14 and 2.71:", Min(3.14, 2.71))

	fmt.Println("\n---------- Named Return Values ----------")
	a, b := randomInts()
	fmt.Printf("Two random ints: %d, %d\n", a, b)

	fmt.Println("\n---------- Control Flow (switch, for) ----------")
	choice := 2
	switch choice {
	case 1:
		fmt.Println("Choice is 1")
	case 2:
		fmt.Println("Choice is 2")
	default:
		fmt.Println("Choice is something else")
	}

	for i := 0; i < 3; i++ {
		fmt.Println("Loop iteration:", i)
	}

	fmt.Println("\n---------- Concurrency (goroutines, channels) ----------")
	var wg sync.WaitGroup
	msgCh := make(chan string, 5)

	// Start 3 workers
	for i := 1; i <= 3; i++ {
		wg.Add(1)
		go worker(i, &wg, msgCh)
	}

	messages := []string{"alpha", "beta", "gamma", "delta", "epsilon"}
	for _, m := range messages {
		msgCh <- m
	}
	close(msgCh)

	wg.Wait()
	fmt.Println("All workers have finished.")

	fmt.Println("\n---------- Done ----------")
}
