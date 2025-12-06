#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(unused_variables)]
#![allow(unused_mut)]

use std::collections::HashMap;
use std::fmt;
use std::future::Future;
use std::pin::Pin;

// Extern block for C FFI
extern "C" {
    fn abs(input: i32) -> i32;
}

// Extern function definition
pub extern "C" fn callable_from_c(x: i32) -> i32 {
    x * 2
}

// Visibility modifiers
pub mod visibility_examples {
    pub struct PublicStruct {
        pub public_field: i32,
        pub(crate) crate_visible: i32,
        pub(super) parent_visible: i32,
        private_field: i32,
    }

    pub(crate) fn crate_visible_function() {}
    pub(super) fn parent_visible_function() {}
    pub fn public_function() {}
}

// Enums and Pattern Matching
pub enum Message {
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

// Async function
async fn fetch_data() -> String {
    String::from("async data")
}

// Async function with return type
pub async fn async_operation(input: i32) -> Result<i32, String> {
    Ok(input * 2)
}

// Unsafe function
unsafe fn dangerous_operation() {
    // Unsafe code here
}

// Function with unsafe block
fn safe_wrapper() {
    unsafe {
        dangerous_operation();
    }
}

// Static mut (requires unsafe to access)
static mut COUNTER: i32 = 0;

// Unsafe trait
unsafe trait UnsafeTrait {
    fn unsafe_method(&self);
}

unsafe impl UnsafeTrait for Point {
    fn unsafe_method(&self) {}
}

fn main() {
    // Mutable variables
    let mut counter = 0;
    counter += 1;

    let mut mutable_string = String::from("hello");
    mutable_string.push_str(" world");

    // Mutable reference
    let mut value = 42;
    let mutable_ref: &mut i32 = &mut value;
    *mutable_ref += 1;

    // Ref pattern in match
    let reference = &42;
    match reference {
        ref r => println!("Got a reference: {:?}", r),
    }

    // Ref mut pattern
    let mut mutable_value = 10;
    match mutable_value {
        ref mut m => {
            *m += 5;
        }
    }

    // Ref in let binding
    let ref immutable_ref = 100;
    let ref mut mutable_binding = 200;

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

    // Unsafe block examples
    unsafe {
        // Access static mut
        COUNTER += 1;
        println!("Counter: {}", COUNTER);

        // Call extern function
        let result = abs(-5);
        println!("Absolute value: {}", result);

        // Raw pointer operations
        let mut num = 5;
        let raw_ptr = &mut num as *mut i32;
        *raw_ptr = 10;
    }
}
