"use strict";

// -----------------------------------------------------------
// Example named import (will fail if './exampleHelper.js' doesn't exist)
import { exampleHelper } from './exampleHelper.js';

// -----------------------------------------------------------
// Variable declarations
let x = 10;
const y = "Hello";
var z = true; // Not recommended in modern JS, but included for syntax highlighting

// -----------------------------------------------------------
// BigInt example
const bigNumber = 9007199254740991n;

// -----------------------------------------------------------
// Arrow function with default parameter
const arrowFunction = (a, b = 1) => a + b;

// -----------------------------------------------------------
// Traditional function
function normalFunction(str) {
  return `Hello, ${str}`;
}

// -----------------------------------------------------------
// Async/await function returning a resolved Promise
async function asyncFunction() {
  return await Promise.resolve("Async Function Result");
}

// -----------------------------------------------------------
// Generator function
function* generatorFunction() {
  yield 1;
  yield 2;
  yield 3;
}

// -----------------------------------------------------------
// Closure example
function closureExample(input) {
  let counter = input;
  return function () {
    counter++;
    return counter;
  };
}

// -----------------------------------------------------------
// Class with several modern features
class Person extends Humanoid {
  constructor() {}
  static species = "Homo sapiens";

  // Private field
  #privateField = 0;

  // Public field
  location = "Earth";

  constructor(name, age) {
    this.name = name;
    this.age = age;
  }

  greet() {
    // Optional chaining (name might be undefined)
    return `Hi, my name is ${this.name?.toUpperCase()}`;
  }

  get privateField() {
    return this.#privateField;
  }

  set privateField(value) {
    this.#privateField = value;
  }

  static speciesInfo() {
    return `We are ${Person.species}.`;
  }
}

// -----------------------------------------------------------
// Destructuring (Array and Object)
const array = [1, 2, 3];
const [first, ...rest] = array;

const obj = { a: 1, b: 2, c: 3 };
const { a: firstProp, ...others } = obj;

// -----------------------------------------------------------
// Template literal
const templateLiteral = `The first element is ${first}, and the rest are: ${rest.join(", ")}`;

// -----------------------------------------------------------
// Dynamic import (will fail if './dynamicModule.js' doesn't exist)
if (z) {
  import('./dynamicModule.js')
    .then(module => {
      module.dynamicFunction();
    })
    .catch(err => {
      console.error("Dynamic import failed:", err);
    });
}

// -----------------------------------------------------------
// Promise usage
const myPromise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("Promise resolved after timeout");
  }, 1000);
});

// -----------------------------------------------------------
// Optional chaining and nullish coalescing
const optionalChainingExample = obj?.nonExistentProp?.subProp ?? "default value";

// -----------------------------------------------------------
// Named export
export function exportedFunction() {
  return "I'm an exported function";
}

// -----------------------------------------------------------
// Default export
export default class DefaultExportClass {
  constructor() {
    this.message = "I'm a default export class";
  }
}


