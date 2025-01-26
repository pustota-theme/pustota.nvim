package example.syntax

import scala.util.{Try, Success, Failure}
import scala.concurrent.{Future, ExecutionContext}
import scala.concurrent.ExecutionContext.Implicits.global

// Abstract & Sealed trait example
sealed trait BinaryTree[+A]
case class Leaf[A](value: A) extends BinaryTree[A]
case class Node[A](left: BinaryTree[A], right: BinaryTree[A]) extends BinaryTree[A]

// Simple trait with a method
trait Printable {
  def printMe(): Unit
}

// Class Person extends Printable
// Companion object provides an apply method for concise instantiation
class Person(val name: String, val age: Int) extends Printable {
  override def printMe(): Unit = {
    println(s"I am $name, and I am $age years old.")
  }
}

object Person {
  def apply(name: String, age: Int): Person = new Person(name, age)
}

// Another class demonstrating type parameters, constructor defaults, and method
class Box[T](val content: T) {
  def isEmpty: Boolean = content == null
}

object Box {
  def apply[T](content: T): Box[T] = new Box[T](content)
}

// A type alias example
package object syntax {
  type StringBox = Box[String]
}

// Demonstrating pattern matching
object PatternMatcher {
  def describePerson(p: Person): String = p match {
    case Person("Alice", 30)      => "This is Alice who is 30 years old."
    case Person(n, a) if a < 18   => s"$n is under 18."
    case Person(n, a)            => s"This is $n, age $a."
  }
}

// Demonstrating Future usage with a for-comprehension
object FutureExample {
  def fetchDataFromServer(id: Int): Future[String] = Future {
    // Simulate a server call
    s"Data for ID $id"
  }

  def processAllData(): Future[List[Int]] = {
    val ids = List(100, 101, 102)
    val futures: List[Future[String]] = ids.map { id =>
      fetchDataFromServer(id)
    }
    // for-comprehension over a list of Future results
    Future.sequence(futures).map { dataList =>
      dataList.map(_.length)
    }
  }
}

// Demonstrating try/catch/finally
object ExceptionHandling {
  def safeDivide(a: Int, b: Int): Int = {
    try {
      a / b
    } catch {
      case e: ArithmeticException =>
        println(s"Exception: ${e.getMessage}")
        0
    } finally {
      println("Division attempt finished.")
    }
  }
}

// Implicit class for extension methods
object Implicits {
  implicit class StringOps(val s: String) extends AnyVal {
    def exclaim: String = s + "!"
  }
}

// Main object to run some tests
object TestHighlight {
  def main(args: Array[String]): Unit = {

    // Using Person class and companion object
    val bob = Person("Bob", 25)
    val alice = Person("Alice", 30)
    bob.printMe()
    println(PatternMatcher.describePerson(bob))
    println(PatternMatcher.describePerson(alice))

    // Using Box class and type alias
    val strBox: StringBox = Box("Hello, Box!")
    println(s"Box content: ${strBox.content}, isEmpty: ${strBox.isEmpty}")

    // Working with sealed trait and case classes
    val tree: BinaryTree[Int] = Node(Leaf(1), Node(Leaf(2), Leaf(3)))
    println(s"Tree structure: $tree")

    // Using for-comprehension with Futures
    FutureExample.processAllData().onComplete {
      case Success(lengths) => println(s"Lengths of fetched data: $lengths")
      case Failure(ex) => println(s"Failed with exception: ${ex.getMessage}")
    }

    // Try/catch/finally example
    println(s"Safe divide 10 by 2: ${ExceptionHandling.safeDivide(10, 2)}")
    println(s"Safe divide 10 by 0: ${ExceptionHandling.safeDivide(10, 0)}")

    // Implicit class usage
    import Implicits._
    println("Hello".exclaim)

    // Keep the main thread alive for asynchronous code to complete
    // (not strictly necessary in some environments)
    Thread.sleep(1000L)
  }
}
