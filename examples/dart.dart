import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

/// A top-level constant.
const String globalGreeting = 'Hello from global const';

/// A top-level function for demonstration.
String saySomething(String message) => 'You said: $message';

/// An enum to show how enums look in Dart.
enum Color {
  red,
  green,
  blue,
}

/// An abstract class to demonstrate inheritance and abstract method.
abstract class Animal {
  String name;

  Animal(this.name);

  void makeSound(); // Abstract method.

  @override
  String toString() => 'Animal(name: $name)';
}

/// A mixin to demonstrate how mixins work in Dart.
mixin Walker {
  void walk() {
    print('Walk mixin: I’m walking...');
  }
}

/// A class that extends an abstract class and uses a mixin.
class Dog extends Animal with Walker {
  // A static variable (class-wide) in Dart.
  static int dogCount = 0;

  /// A final instance variable.
  final String breed;

  // A late variable (initialized later, but non-nullable).
  late int age;

  Dog(String name, this.breed, {int? initialAge}) : super(name) {
    dogCount++;
    // If initialAge is null, age defaults to 0
    age = initialAge ?? 0;
  }

  // Concrete implementation of abstract method from Animal.
  @override
  void makeSound() {
    print('$name says: Woof!');
  }

  /// A named constructor.
  Dog.puppy(String name, String breed) : this(name, breed, initialAge: 0);

  /// A factory constructor example: could return a cached instance or something else.
  factory Dog.withRandomName() {
    final randomId = math.Random().nextInt(1000);
    return Dog('Dog#$randomId', 'Unknown', initialAge: 1);
  }

  // Demonstrates using a normal method that returns a Future.
  Future<void> checkUp() async {
    print('$name is having a check-up...');
    await Future.delayed(Duration(seconds: 1));
    print('$name check-up done!');
  }

  @override
  String toString() => 'Dog(name: $name, breed: $breed, age: $age)';
}

/// Another class to demonstrate generics along with extension methods.
class Box<T> {
  T content;
  Box(this.content);

  @override
  String toString() => 'Box containing: $content';
}

/// Extension on int, for demonstration.
extension IntExtensions on int {
  bool get isEvenNumber => this % 2 == 0;
}

/// Custom exception example.
class CustomException implements Exception {
  final String message;
  CustomException(this.message);

  @override
  String toString() => 'CustomException: $message';
}

/// An async generator function that returns a Stream of integers.
Stream<int> countStream(int maxCount) async* {
  for (var i = 1; i <= maxCount; i++) {
    yield i;
    await Future.delayed(const Duration(milliseconds: 200));
  }
}

/// The main entry point for the app.
Future<void> main() async {
  print(globalGreeting);

  // Simple usage of top-level function.
  print(saySomething('Testing Neovim syntax highlighting!'));

  // Using the enum Color.
  const currentColor = Color.green;
  switch (currentColor) {
    case Color.red:
      print('Color is red.');
      break;
    case Color.green:
      print('Color is green.');
      break;
    case Color.blue:
      print('Color is blue.');
      break;
  }

  // Creating a Dog instance using named and factory constructors.
  var puppy = Dog.puppy('Buddy', 'Golden Retriever')..age = 1;
  var randomDog = Dog.withRandomName();

  // Demonstrating the cascade operator and null-aware access.
  puppy
    ..age = 2
    ..makeSound()
    ..walk();

  randomDog?.makeSound(); // The randomDog is not null, but ?. shows syntax usage.

  // Exception handling example.
  try {
    throw CustomException('Something went wrong!');
  } on CustomException catch (e) {
    print('Caught custom exception: $e');
  } finally {
    print('Finally block executed.');
  }

  // Using the async method in the Dog class.
  await puppy.checkUp();

  // Generics example with "Box" class.
  var intBox = Box<int>(42);
  var stringBox = Box<String>('A string in a box');
  print(intBox);
  print(stringBox);

  // Extension method usage.
  var testNumber = 5;
  print('$testNumber is even? ${testNumber.isEvenNumber}');

  // Demonstrate stream usage and async iteration.
  await for (var value in countStream(5)) {
    print('countStream emitted: $value');
  }

  // A quick check on static variable usage.
  print('Number of dogs created: ${Dog.dogCount}');
}
