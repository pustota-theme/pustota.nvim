package com.example.syntax;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.function.Consumer;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Record (Java 16+)
 * A compact, immutable data carrier.
 */
public record PersonRecord(String name, int age) {}

// Enum
enum Color {
    RED, GREEN, BLUE
}

// Sealed Interface (Java 17+)
sealed interface Shape permits Circle, Rectangle {
    double area();
}

// Final class implementing sealed interface
final class Circle implements Shape {
    private final double radius;
    public Circle(double radius) {
        this.radius = radius;
    }
    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}

// Non-sealed class implementing sealed interface
non-sealed class Rectangle implements Shape {
    private final double width;
    private final double height;
    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }
    @Override
    public double area() {
        return width * height;
    }
}

/**
 * Demo class showcasing various Java features.
 */
public class SampleAllFeatures {

    // Static variable
    private static int staticCounter = 0;

    // Instance variable
    private String instanceVar = "Hello";

    // Generic method
    public static <T> void printArrayElements(T[] array) {
        for (T element : array) {
            System.out.println("Element: " + element);
        }
    }

    // Overloaded method
    public static void printArrayElements(int[] array) {
        for (int element : array) {
            System.out.println("Int Element: " + element);
        }
    }

    public static void main(String[] args) {
        // Local variable type inference (Java 10+)
        var localList = new ArrayList<String>();
        localList.add("Apple");
        localList.add("Banana");

        // Lambda + Stream API
        localList.stream()
                 .filter(item -> item.startsWith("A"))
                 .forEach(System.out::println);

        // Switch expression (Java 14+)
        var color = Color.GREEN;
        var colorMessage = switch (color) {
            case RED -> "Color is RED";
            case GREEN -> "Color is GREEN";
            case BLUE -> "Color is BLUE";
        };
        System.out.println("Switch expression result: " + colorMessage);

        // Text block (Java 15+)
        String jsonTextBlock = """
            {
                "language": "Java",
                "version": 17
            }
            """;
        System.out.println("Text block example:\n" + jsonTextBlock);

        // Generics + Collections
        Map<String, PersonRecord> personMap = new HashMap<>();
        personMap.put("John", new PersonRecord("John Doe", 30));
        personMap.put("Jane", new PersonRecord("Jane Smith", 25));

        // Method reference usage
        personMap.values().forEach(System.out::println);

        // Using an Array, calling overloaded methods
        Integer[] intObjectArray = { 1, 2, 3 };
        printArrayElements(intObjectArray);

        int[] intPrimitiveArray = { 10, 20, 30 };
        printArrayElements(intPrimitiveArray);

        // Creating shapes, demonstrating sealed classes
        Shape circle = new Circle(3.0);
        Shape rectangle = new Rectangle(4.0, 5.0);

        System.out.println("Circle area: " + circle.area());
        System.out.println("Rectangle area: " + rectangle.area());

        // Increment static variable
        System.out.println("Static counter before: " + staticCounter);
        staticCounter++;
        System.out.println("Static counter after: " + staticCounter);

        // Anonymous inner class
        Consumer<String> printer = new Consumer<>() {
            @Override
            public void accept(String t) {
                System.out.println("Anonymous inner class printing: " + t);
            }
        };
        printer.accept("Hello from Consumer!");

        // Varargs demonstration
        var concatenated = concatenateStrings("One", "Two", "Three");
        System.out.println("Varargs concatenation: " + concatenated);
    }

    // Varargs method
    public static String concatenateStrings(String... strings) {
        return Arrays.stream(strings)
                     .collect(Collectors.joining(" | "));
    }
}

