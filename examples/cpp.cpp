#include <string>
#include <vector>
#include <array>
#include <map>
#include <memory>
#include <type_traits>
#include <utility>
#include <algorithm>
#include <stdexcept>
#include <functional>
#include <cstdint>

// Preprocessor directives and macros
#ifndef MY_MACRO
#define MY_MACRO(x) ((x) + 42)
#endif

// A constexpr function
constexpr int multiplyConstexpr(int x, int y) {
    return x * y;
}

// A union
union MyUnion {
    int    i;
    float  f;
    MyUnion() : i(0) {} // Default initializes i
};

// An enum with an underlying type
enum Color : uint8_t {
    Red   = 1,
    Green = 2,
    Blue  = 3
};

// Scoped enum
enum class Fruit {
    Apple,
    Banana,
    Cherry
};

// A basic struct
struct MyStruct {
    int x;
    double y;
    MyStruct() : x(0), y(0.0) {}
};

// A simple base class
class Base {
public:
    // Virtual destructor
    virtual ~Base() {
        std::cout << "[Base destructor]\n";
    }

    // Virtual function
    virtual void foo() const {
        std::cout << "Base foo\n";
    }
};

// A derived class
class Derived : public Base {
public:
    Derived() {
        std::cout << "[Derived constructor]\n";
    }

    ~Derived() override {
        std::cout << "[Derived destructor]\n";
    }

    void foo() const override {
        std::cout << "Derived foo\n";
    }
};

// A function template with if constexpr from C++17
template <typename T, typename U>
auto add(const T& a, const U& b) {
    if constexpr (std::is_same_v<T, std::string> && std::is_same_v<U, std::string>) {
        return a + " " + b; // Concatenate with a space
    } else {
        return a + b;       // Numeric addition or other valid operator+
    }
}

// C++20 concept
template <typename T>
concept Integral = std::is_integral_v<T>;

// A function template constrained by a concept
template <Integral T>
T doubleValue(T x) {
    return x * 2;
}

// A function pointer type
using FuncPtr = int(*)(int, int);

// A simple free function matching FuncPtr
int multiplyFunc(int a, int b) {
    return a * b;
}

int main() {
    // Basic variables
    int a = 10;
    double b = 3.14;
    bool c = true;
    char d = 'A';

    // Raw string literal
    std::string hello = R"(Hello "raw" world!)";

    // Arrays (std::array)
    std::array<int, 3> arr = {1, 2, 3};

    // Vectors
    std::vector<std::string> vec = {"Hello", "World"};

    // Map
    std::map<std::string, int> mp;
    mp["One"] = 1;
    mp["Two"] = 2;

    // Using the struct
    MyStruct s;
    s.x = 1234;
    s.y = 56.78;

    // Enum
    Color col = Red;

    // Enum class
    Fruit fr = Fruit::Banana;

    // Using a union
    MyUnion u;
    u.i = 42; // set integer field

    // Creating a unique_ptr to a Derived (polymorphism)
    std::unique_ptr<Base> ptr = std::make_unique<Derived>();
    ptr->foo(); // Calls Derived::foo()

    // Using our template function
    auto sumInt = add(5, 10); // int + int
    std::string sumStr = add(std::string{"Hello"}, std::string{"World"}); // string + string

    // Using a lambda
    auto printLambda = [](auto val) {
        std::cout << val << "\n";
    };
    printLambda(sumInt);
    printLambda(sumStr);

    // if constexpr to check pointer size
    if constexpr (sizeof(void*) == 8) {
        std::cout << "Running on a 64-bit system.\n";
    } else {
        std::cout << "Running on a system that is not 64-bit.\n";
    }

    // Structured bindings (C++17)
    std::pair<int, std::string> p{42, "Answer"};
    auto [num, str] = p;
    std::cout << num << " : " << str << "\n";

    // Range-based for loop
    for (const auto& item : vec) {
        std::cout << item << " ";
    }
    std::cout << "\n";

    // Using our concept-based function
    int doubled = doubleValue(21);
    printLambda(doubled);

    // Try-catch block for exceptions
    try {
        throw std::runtime_error("An example exception!");
    } catch (const std::exception &e) {
        std::cerr << "Caught exception: " << e.what() << "\n";
    }

    // Demonstrate the function pointer
    FuncPtr fptr = multiplyFunc;
    std::cout << "Function pointer multiplyFunc(6,7) = " << fptr(6, 7) << "\n";

    // Macro usage (adds 42)
    std::cout << "MY_MACRO(10) = " << MY_MACRO(10) << "\n";

    // Static assert
    static_assert(sizeof(int) == 4, "int must be 32-bit on this platform for this example!");

    // A constexpr call
    constexpr int product = multiplyConstexpr(3, 7);
    std::cout << "constexpr multiplyConstexpr(3,7) = " << product << "\n";

    return 0;
}
