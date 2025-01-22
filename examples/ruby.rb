# Constants
CONSTANT_A      = 123
CONSTANT_STRING = "Global Hello"

# A module with a constant, a class method, and an instance method
module MyModule
  VERSION = "1.0.0"

  def self.module_method(arg1, *args)
    puts "MyModule.module_method called with arg1: #{arg1} and args: #{args.inspect}"
  end

  def included_method
    puts "This is an instance method included from MyModule"
  end
end

# A class that includes the module
class MyClass
  include MyModule

  @@class_variable = 42

  attr_accessor :instance_var

  def initialize(instance_var = nil)
    @instance_var = instance_var || Time.now
  end

  # Class method
  def self.class_method
    puts "MyClass.class_method called, @@class_variable = #{@@class_variable}"
  end

  # Basic instance method with variable arguments and a block
  def instance_method(*args)
    puts "instance_method called with args: #{args.inspect}"
    local_var = args.map { |v| v.to_s.upcase }

    local_var.each do |val|
      puts "Block iteration: #{val}"
    end
  end

  # Demonstrates exception handling
  def method_with_rescue
    begin
      raise "Oops, something went wrong!"
    rescue => e
      warn "Rescued an error: #{e.message}"
    ensure
      puts "This is the ensure block, always executed"
    end
  end

  # Demonstrates usage of a lambda
  def method_with_lambda
    doubler = ->(x) { x * 2 }
    5.times do |i|
      puts "Lambda call(#{i}): #{doubler.call(i)}"
    end
  end

  # Demonstrates regex matching
  def method_with_regex(str)
    if str =~ /^hello/i
      puts "String '#{str}' starts with 'hello' (case-insensitive)"
    else
      puts "String '#{str}' does not match the regex"
    end
  end

  # Demonstrates case statement with a range
  def method_with_case(value)
    case value
    when 1
      puts "Value is 1"
    when 2..10
      puts "Value is between 2 and 10"
    else
      puts "Value is something else (#{value})"
    end
  end

  # Demonstrates yielding to a block
  def method_with_block
    yield "Yield called from method_with_block" if block_given?
  end

  # Demonstrates 'until' loop
  def method_with_until
    counter = 0
    until counter > 2
      puts "Until loop counter: #{counter}"
      counter += 1
    end
  end

  # Demonstrates 'while' loop
  def method_with_while
    counter = 0
    while counter < 3
      puts "While loop counter: #{counter}"
      counter += 1
    end
  end

  # Demonstrates 'for' loop
  def method_with_for
    for i in [10, 20, 30]
      puts "For loop item: #{i}"
    end
  end
end

# Main guard to only run if the script is not required by another file
if __FILE__ == $0
  # Module method call
  MyModule.module_method("TestArg", 1, 2, 3)

  # Class method call
  MyClass.class_method

  # Instantiate MyClass
  obj = MyClass.new("InitialValue")

  # Various method calls demonstrating multiple Ruby features
  obj.instance_method("hello", :symbol, 123)
  obj.method_with_rescue
  obj.method_with_lambda
  obj.method_with_regex("Hello world!")
  obj.method_with_regex("Something else")
  obj.method_with_case(1)
  obj.method_with_case(5)
  obj.method_with_case(50)
  obj.method_with_block { |msg| puts "Block says: #{msg}" }
  obj.method_with_until
  obj.method_with_while
  obj.method_with_for

  # Demonstrate string interpolation, hash, array, symbols, etc.
  some_hash  = { a: 1, b: 2, :c => 3 }
  some_array = ["foo", "bar", :baz, 42]

  puts "Hash content: #{some_hash.inspect}"
  puts 'Array content: ' + some_array.inspect

  # Example of a heredoc
  multiline_string = <<~HEREDOC
    This is a heredoc example.
    It can span multiple lines.
    Neovim should highlight this differently from normal strings.
  HEREDOC

  puts multiline_string

  # Simple conditional demonstration
  puts "CONSTANT_A is #{CONSTANT_A}" if CONSTANT_A == 123
end
