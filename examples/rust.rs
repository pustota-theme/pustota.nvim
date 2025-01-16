#![allow(dead_code)]
#![allow(unused_imports)]

use std::collections::HashMap;
use std::fmt;

// Enums and Pattern Matching
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

// Trait
trait Summary {
    fn summarize(&self) -> String;
}

struct Book {
    title: String,
    author: String,
    year: u32,
}

// Implementing Trait for a Struct
impl Summary for Book {
    fn summarize(&self) -> String {
        format!("{}, by {} ({})", self.title, self.author, self.year)
    }
}

// Struct
struct Point {
    x: i32,
    y: i32,
}

// Implementing methods for a struct
impl Point {
    fn new(x: i32, y: i32) -> Self {
        Point { x, y }
    }

    fn magnitude(&self) -> f64 {
        ((self.x.pow(2) + self.y.pow(2)) as f64).sqrt()
    }
}

// Generics
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {
    let mut largest = list[0];
    for &item in list.iter() {
        if item > largest {
            largest = item;
        }
    }
    largest
}

// Lifetimes
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Closures and Iterators
fn iterator_example() {
    let vec = vec![1, 2, 3];
    let sum: i32 = vec.iter().map(|x| x * 2).sum();
    assert_eq!(sum, 12);
}

fn main() {
    // Basic Types and Ownership
    let s1 = String::from("hello");
    let s2 = s1.clone();

    // Enums and Pattern Matching
    let msg = Message::Write(String::from("hello"));
    match msg {
        Message::Quit => println!("Quit"),
        Message::Move { x, y } => println!("Move to {} {}", x, y),
        Message::Write(text) => println!("Text message: {}", text),
        Message::ChangeColor(r, g, b) => println!("Change the color to {}, {}, {}", r, g, b),
    }

    // Struct and Method
    let p = Point::new(3, 4);
    println!("Magnitude of point: {}", p.magnitude());

    // Trait Example
    let book = Book {
        title: String::from("The Rust Book"),
        author: String::from("Some Author"),
        year: 2021,
    };
    println!("Book Summary: {}", book.summarize());

    // Generics and Lifetimes
    let numbers = vec![34, 50, 25, 100, 65];
    println!("The largest number is {}", largest(&numbers));
    
    let string1 = String::from("abcd");
    let string2 = "xyz";
    println!("The longest string is '{}'", longest(string1.as_str(), string2));

    // Closures and Iterators
    iterator_example();
    
    // Result and Option
    let x: Result<i32, &str> = Ok(5);
    let y: Option<i32> = Some(5);

    // unwrap and match for Result
    match x {
        Ok(val) => println!("Result is Ok: {}", val),
        Err(err) => println!("Error: {}", err),
    }

    // if let and while let for option
    if let Some(value) = y {
        println!("Option is Some: {}", value);
    }
    
    // Concurrency with Threads and Channels
    use std::thread;
    use std::sync::mpsc;
    let (tx, rx) = mpsc::channel();

    thread::spawn(move || {
        tx.send(String::from("Hello from thread")).unwrap();
    });

    let received = rx.recv().unwrap();
    println!("Got: {}", received);
    
    // Basic Error Handling
    fn divide(a: i32, b: i32) -> Result<i32, String> {
        if b == 0 {
            Err(String::from("Cannot divide by zero"))
        } else {
            Ok(a / b)
        }
    }

    match divide(10, 2) {
        Ok(result) => println!("Result: {}", result),
        Err(e) => println!("Error: {}", e),
    }
}
