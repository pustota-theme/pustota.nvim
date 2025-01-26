package com.example.syntax

import kotlin.math.PI
import kotlin.properties.Delegates
import kotlin.random.Random
import kotlinx.coroutines.*

/**
 * Type alias example.
 */
typealias StringList = List<String>

/**
 * Sealed class example to demonstrate usage of Success, Error, and Loading states.
 */
sealed class Result<out T> {
    data class Success<out T>(val data: T) : Result<T>()
    data class Error(val message: String) : Result<Nothing>()
    object Loading : Result<Nothing>()
}

/**
 * Enum class demonstrating how to implement methods in enums.
 */
enum class Direction {
    NORTH, EAST, SOUTH, WEST;

    fun turnRight(): Direction = when (this) {
        NORTH -> EAST
        EAST -> SOUTH
        SOUTH -> WEST
        WEST -> NORTH
    }
}

/**
 * Simple interface with two methods.
 */
interface Shape {
    fun area(): Double
    fun perimeter(): Double
}

/**
 * Class implementing the Shape interface.
 */
class Circle(private val radius: Double) : Shape {
    override fun area(): Double = PI * radius * radius
    override fun perimeter(): Double = 2 * PI * radius

    fun displayInfo() {
        println("Circle with radius: $radius")
    }
}

/**
 * Data class to demonstrate immutable data objects with copy and destructuring.
 */
data class User(val id: Int, val name: String)

/**
 * Extension function example.
 */
fun String.lastChar(): Char = this[this.length - 1]

/**
 * Inline + reified example.
 */
inline fun <reified T> isInstanceOf(value: Any): Boolean = value is T

/**
 * Higher-order function example using a lambda.
 */
fun <T> runOperation(value: T, op: (T) -> Unit) {
    op(value)
}

/**
 * An object declaration (Singleton) for logging.
 */
object Logger {
    fun log(message: String) {
        println("LOG: $message")
    }
}

/**
 * Class demonstrating a companion object and property usage.
 */
class UserRepository {
    var currentUser: User? = null

    companion object {
        const val DEFAULT_USER_ID = -1
    }

    fun fetchUser(): User = User(Random.nextInt(1000), "John Doe")

    fun defaultUser(): User = User(DEFAULT_USER_ID, "Guest")
}

/**
 * Class showcasing lazy initialization and property delegation (observable).
 */
class Example {
    private val lazyValue: String by lazy {
        "Lazy initialization"
    }

    private var observedValue: Int by Delegates.observable(0) { property, oldValue, newValue ->
        println("${property.name} changed from $oldValue to $newValue")
    }

    fun doSomething() {
        // Accessing a lazy-initialized property
        println(lazyValue)

        // Changing an observable property
        observedValue = 10
    }
}

/**
 * Main function demonstrating multiple features to test syntax highlighting.
 */
fun main() {
    // 1. Enum usage
    val direction = Direction.NORTH
    println("Current direction: $direction")
    println("Right turn leads to: ${direction.turnRight()}")

    // 2. Sealed class usage
    val result: Result<Int> = Result.Success(42)
    when (result) {
        is Result.Success -> println("Success with data ${result.data}")
        is Result.Error -> println("Error with message ${result.message}")
        Result.Loading -> println("Loading...")
    }

    // 3. Interface + class usage
    val circle: Shape = Circle(5.5)
    println("Circle area: ${circle.area()}")
    println("Circle perimeter: ${circle.perimeter()}")

    // Smart-cast to Circle to access class-specific method
    if (circle is Circle) circle.displayInfo()

    // 4. Data class usage + destructuring
    val user1 = User(1, "Alice")
    val user2 = user1.copy(name = "Bob")
    println("User1: $user1")
    println("User2: $user2")

    // 5. Inline + reified function
    println(isInstanceOf<String>("Hello"))  // true
    println(isInstanceOf<Int>("Hello"))     // false

    // 6. Higher-order function
    runOperation(5) { println("Value is $it") }

    // 7. Singleton usage
    Logger.log("Test logging from Logger object")

    // 8. Companion object usage within UserRepository
    val userRepository = UserRepository()
    val fetchedUser = userRepository.fetchUser()
    userRepository.currentUser = fetchedUser
    println("Fetched user: $fetchedUser")

    val defaultUser = userRepository.defaultUser()
    println("Default user: $defaultUser")

    // 9. Property delegation + lazy in Example class
    val example = Example()
    example.doSomething()

    // 10. Collections usage
    val numbers = listOf(1, 2, 3, 4)
    val doubledNumbers = numbers.map { it * 2 }.filter { it > 4 }
    println("Doubled numbers > 4: $doubledNumbers")

    // 11. Type alias usage
    val stringList: StringList = listOf("Kotlin", "is", "awesome!")
    println("String list: $stringList")

    // 12. Coroutines usage
    runBlocking {
        launch {
            delay(200)
            println("Coroutine says hello!")
        }
    }

    // 13. Destructuring
    val (id, name) = user1
    println("Destructured: id = $id, name = $name")

    // 14. Try/catch/finally
    try {
        val x = 10 / 0
        println(x)
    } catch (e: ArithmeticException) {
        println("Caught an arithmetic exception!")
    } finally {
        println("Finally block reached.")
    }

    // 15. with usage
    with(circle as Circle) {
        displayInfo()
        println("Area from 'with': ${area()}")
    }

    // 16. Reflection usage
    val kClass = circle::class
    println("Class name via reflection: ${kClass.simpleName}")
    kClass.members.forEach {
        println("Member: ${it.name}")
    }

    // 17. Extension function usage
    val sampleString = "Hello!"
    println("Extension function lastChar: '${sampleString.lastChar()}'")
}
