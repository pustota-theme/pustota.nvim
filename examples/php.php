<?php

declare(strict_types=1);

namespace NeovimTest;

use Exception;
use Throwable;

/**
 * This file is meant to show off many of PHP's features.
 * You can use it to test syntax highlighting in Neovim.
 */

const GLOBAL_CONST = 'GLOBAL_CONST_VALUE';
define('ANOTHER_CONST', 42);

/**
 * Interface example
 */
interface MyInterface
{
    public function doSomething(): void;
}

/**
 * Trait example
 */
trait MyTrait
{
    public function traitMethod(): string
    {
        return "Trait method called";
    }
}

/**
 * Abstract base class
 */
abstract class AbstractBase
{
    abstract public function abstractMethod(): string;

    public function baseMethod(): void
    {
        echo "Base method called\n";
    }
}

/**
 * Class implementing MyInterface and extending an abstract class
 */
class MyClass extends AbstractBase implements MyInterface
{
    use MyTrait;

    private ?string $prop;

    public function __construct(?string $prop = null)
    {
        $this->prop = $prop;
    }

    public function doSomething(): void
    {
        echo "Doing something...\n";
    }

    public function getProp(): ?string
    {
        return $this->prop;
    }

    public function setProp(?string $value): void
    {
        $this->prop = $value;
    }

    public function abstractMethod(): string
    {
        return "Abstract method implemented";
    }

    public static function staticMethod(int $x): int
    {
        return $x * 2;
    }
}

/**
 * Example generator function
 */
function generatorFunction(int $limit): \Generator
{
    for ($i = 0; $i < $limit; $i++) {
        yield $i => $i * $i;
    }
}

/**
 * Demonstrates referencing a variable
 */
function referenceIncrement(int &$number): void
{
    $number++;
}

/**
 * Demonstrates creating and returning an arrow function
 */
function testArrowFunction(): \Closure
{
    $factor = 10;
    // Return an arrow function capturing $factor by value
    return fn($value) => $value * $factor;
}

/**
 * Main function to run various tests
 */
function main(): void
{
    echo "GLOBAL_CONST: " . GLOBAL_CONST . "\n";
    echo "ANOTHER_CONST: " . ANOTHER_CONST . "\n";

    $obj = new MyClass("Hello World");

    // From the abstract base class
    $obj->baseMethod();

    // From our interface implementation
    $obj->doSomething();

    // From the trait
    echo $obj->traitMethod() . "\n";

    // Array example
    $arr = [1, 2, 3, "key" => "value"];
    foreach ($arr as $k => $v) {
        echo "[$k] => $v\n";
    }

    // For loop with alternative syntax
    for ($i = 0; $i < 3; $i++):
        echo "For loop iteration $i\n";
    endfor;

    // Using the generator
    $gen = generatorFunction(5);
    foreach ($gen as $k => $v) {
        echo "Generator key $k => $v\n";
    }

    // Reference passing
    $num = 5;
    referenceIncrement($num);
    echo "After reference increment: $num\n";

    // Type casting
    $str = "123";
    $intVal = (int) $str;
    echo "Casted int: $intVal\n";

    // Arrow function usage
    $arrowFn = testArrowFunction();
    echo "Arrow function result (2 * 10): " . $arrowFn(2) . "\n";

    // Closure example
    $closure = function (string $name): string {
        return "Hello, $name!";
    };
    echo $closure("PHP") . "\n";

    // Goto example
    goto skip;
    echo "This line will be skipped\n";
    skip:
    echo "We skipped a line with goto!\n";

    // Exception handling
    try {
        throw new Exception("This is a test exception");
    } catch (Throwable $e) {
        echo "Caught exception: " . $e->getMessage() . "\n";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>PHP Syntax Test</title>
</head>
<body>
    <h1><?php echo "Hello from PHP embedded in HTML!"; ?></h1>
    <?php main(); ?>
</body>
</html>
