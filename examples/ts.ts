let mutableString: string = "Hello, world!";
const constantNumber: number = 42;
let unionType: string | number = "Could be string or number";

// -------------------------------------------------------------------------
// 2. Arrays and Tuples
// -------------------------------------------------------------------------
let numberArray: number[] = [1, 2, 3];
let stringArray: Array<string> = ["alpha", "beta", "gamma"];

// Tuple with fixed number of elements
let myTuple: [string, number] = ["Age", 30];

// -------------------------------------------------------------------------
// 3. Enums
// -------------------------------------------------------------------------
enum Color {
  Red = "RED",
  Green = "GREEN",
  Blue = "BLUE",
}

const backgroundColor: Color = Color.Green;

// -------------------------------------------------------------------------
// 4. Interfaces
// -------------------------------------------------------------------------
interface Person {
  readonly id: number;     // read-only property
  name: string;
  jobTitle?: string;       // optional property
}

// -------------------------------------------------------------------------
// 5. Type Aliases and Intersection Types
// -------------------------------------------------------------------------
type Admin = {
  adminLevel: number;
};

type Manager = {
  managerLevel: number;
};

type AdminManager = Admin & Manager;

// -------------------------------------------------------------------------
// 6. Classes, Abstract Classes, and Decorators
//    (Requires "experimentalDecorators" in tsconfig to see decorator usage)
// -------------------------------------------------------------------------

// Simple decorator example
function sealed(constructor: Function) {
  Object.seal(constructor);
  Object.seal(constructor.prototype);
}

/** Abstract class to demonstrate inheritance */
abstract class Employee {
  constructor(public name: string) {}

  abstract getSalary(): number;
}

@sealed
class Developer extends Employee {
  private languages: string[];

  constructor(name: string, languages: string[]) {
    super(name);
    this.languages = languages;
  }

  get mainLanguage(): string {
    return this.languages[0] || "none";
  }

  set mainLanguage(lang: string) {
    if (this.languages.length > 0) {
      this.languages[0] = lang;
    } else {
      this.languages.push(lang);
    }
  }

  public getSalary(): number {
    return 75000;
  }
}

// -------------------------------------------------------------------------
// 7. Functions, Overloads, Default Parameters, and Rest Parameters
// -------------------------------------------------------------------------
function add(a: number, b: number): number;
function add(a: string, b: string): string;
function add(a: any, b: any): any {
  return a + b;
}

/** Demonstrates default and rest parameters */
function logMessages(prefix = "LOG:", ...messages: string[]): void {
  messages.forEach(msg => {
    console.log(`${prefix} ${msg}`);
  });
}

// -------------------------------------------------------------------------
// 8. Generics
// -------------------------------------------------------------------------
function identity<T>(value: T): T {
  return value;
}

function getArrayItems<T>(items: T[]): T[] {
  return items.slice();
}

// -------------------------------------------------------------------------
// 9. Async/Await, Promises, and Error Handling
// -------------------------------------------------------------------------
async function fetchData(url: string): Promise<any> {
  try {
    const response = await fetch(url);
    const data = await response.json();
    return data;
  } catch (err: unknown) {
    console.error("Failed to fetch data:", err);
    throw err;
  }
}

// -------------------------------------------------------------------------
// 10. Optional Chaining, Nullish Coalescing
// -------------------------------------------------------------------------
function optionalChainingExample(person?: Person) {
  const jobTitle = person?.jobTitle ?? "Unemployed";
  console.log(`Job title is: ${jobTitle}`);
}

// -------------------------------------------------------------------------
// 11. Usage Example Putting It All Together
// -------------------------------------------------------------------------
function main() {
  // Basic variable usage
  console.log(mutableString, constantNumber);

  unionType = 100; // Changing from string to number

  // Array + Tuple
  myTuple[1] = 31;

  // Enum usage
  console.log(backgroundColor, Color.Blue);

  // Interface usage
  const newPerson: Person = { id: 1, name: "Bob", jobTitle: "Tester" };

  // Type intersection usage
  const adminManager: AdminManager = { adminLevel: 2, managerLevel: 3 };
  console.log("Admin Manager:", adminManager);

  // Class usage
  const dev = new Developer("Alice", ["TypeScript", "JavaScript"]);
  dev.mainLanguage = "Rust";
  console.log(`${dev.name} writes code primarily in ${dev.mainLanguage}.`);

  // Function overload usage
  console.log(add(1, 2));
  console.log(add("Hello, ", "world"));

  // Default and rest parameters
  logMessages("DEBUG:", "System start", "Loading modules", "Done");

  // Generics
  const numbers = getArrayItems<number>([10, 20, 30]);
  console.log("Generic array items:", numbers);

  // Async/Await usage (commented out to avoid errors if no fetch is available)
  // fetchData("https://jsonplaceholder.typicode.com/todos/1").then(data => {
  //   console.log("Fetched data:", data);
  // });

  // Optional chaining
  optionalChainingExample(newPerson);
  optionalChainingExample();

  // Try/Catch block with error handling
  try {
    const parsed = JSON.parse("invalid-json"); // This will throw
    console.log("Parsed invalid JSON successfully?", parsed);
  } catch (error) {
    console.error("Caught JSON parse error:", error);
  }
}

// Execute main
main();
