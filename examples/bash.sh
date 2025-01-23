################################################################################
# 1. Basic Variable Assignments & Exports
################################################################################

# Simple variable
my_var="Hello World"
# Exported variable
export MY_EXPORTED_VAR="I am exported"

# Indirect expansion
varname="my_var"
echo "Indirect expansion of varname -> ${!varname}"

# Mixed quotes
echo "Double-quoted: $my_var"
echo 'Single-quoted: $my_var'
echo "Escape sequences: \"\$my_var\""

# Brace expansion
echo {A,B,C,D}"_suffix"

################################################################################
# 2. Command Substitution & Arithmetic Expansion
################################################################################

# Command substitution with $( )
current_time=$(date +"%T")
echo "The current time is $current_time"

# Legacy backticks (not recommended, but shown for highlighting)
echo "Current directory is `pwd`"

# Arithmetic expansion
num1=10
num2=4
sum=$((num1 + num2))
echo "Sum of $num1 and $num2 is $sum"

################################################################################
# 3. Arrays (Indexed & Associative)
################################################################################

# Indexed array
my_array=("apple" "banana" "cherry" "date")
echo "First element of my_array: ${my_array[0]}"
echo "All elements of my_array: ${my_array[@]}"

# Associative array (Bash 4+)
declare -A my_assoc_array
my_assoc_array=(
  ["name"]="Alice"
  ["role"]="Developer"
  ["location"]="Wonderland"
)

echo "Name from associative array: ${my_assoc_array[name]}"
echo "All keys: ${!my_assoc_array[@]}"
echo "All values: ${my_assoc_array[@]}"

################################################################################
# 4. Conditionals & Tests
################################################################################

# if / then / elif / else
if [[ -z "$my_var" ]]; then
  echo "my_var is empty"
elif [[ "$my_var" == "Hello World" ]]; then
  echo "my_var says hello to the world"
else
  echo "my_var has some other value"
fi

# [ ] vs [[ ]]
if [ -n "$MY_EXPORTED_VAR" ]; then
  echo "[Single bracket test] MY_EXPORTED_VAR is not empty"
fi

if [[ "$MY_EXPORTED_VAR" =~ "exported" ]]; then
  echo "[Double bracket regex test] MY_EXPORTED_VAR contains 'exported'"
fi

################################################################################
# 5. Loops (for, while, until)
################################################################################

# for loop
for i in "${my_array[@]}"; do
  echo "For loop item: $i"
done

# Traditional for (( ))
for ((i = 1; i <= 3; i++)); do
  echo "C-style for loop iteration: $i"
done

# while loop
counter=0
while [[ $counter -lt 3 ]]; do
  echo "While loop: counter=$counter"
  ((counter++))
done

# until loop
until [[ $counter -le 0 ]]; do
  echo "Until loop: counter=$counter"
  ((counter--))
done

################################################################################
# 6. Functions
################################################################################

# Function with local variables
my_function() {
  local local_var="I am local"
  echo "Inside function: local_var=$local_var, global_var=$global_var"
}

global_var="I am global"
my_function
echo "Outside function: global_var=$global_var"
# local_var is not accessible here

# Function that returns a status code
check_number() {
  local num="$1"
  if (( num > 10 )); then
    return 0  # success
  else
    return 1  # failure
  fi
}

if check_number 15; then
  echo "15 is greater than 10"
fi

################################################################################
# 7. Case Statement
################################################################################

fruit="banana"
case "$fruit" in
  "apple")
    echo "Fruit is apple"
    ;;
  "banana")
    echo "Fruit is banana"
    ;;
  *)
    echo "Fruit is something else"
    ;;
esac

################################################################################
# 8. Here Document & Here String
################################################################################

cat <<EOF > /dev/null
This is a here-document.
You could write multiple lines here.
This won't actually appear because we redirected to /dev/null.
EOF

# Here-string
grep "Hello" <<< "Hello from a here-string"

################################################################################
# 9. Redirections & Pipes
################################################################################

# Basic output redirection
echo "Redirecting this to a file" > output.txt

# Append redirection
echo "Appending another line" >> output.txt

# Pipe
ls -l | grep -i "bash"

################################################################################
# 10. Subshells & Command Grouping
################################################################################

(
  # This is a subshell; changes here don’t affect the parent shell
  local_subshell_var="inside_subshell"
  echo "In subshell: local_subshell_var=$local_subshell_var"
)

{
  # Command grouping
  echo "Grouped command 1"
  echo "Grouped command 2"
} > grouped_output.txt

################################################################################
# 11. Process Substitution
################################################################################

while read -r line; do
  echo "Process substitution line read: $line"
done < <(echo -e "Line1\nLine2\nLine3")

################################################################################
# 12. Traps & Signals
################################################################################

trap "echo 'SIGINT received; cleaning up...'; exit 1" INT

# Uncomment the sleep line to test trap behavior with Ctrl+C
# echo "Sleeping for 5 seconds (try pressing Ctrl+C)..."
# sleep 5

################################################################################
# 13. Miscellaneous
################################################################################

# Alias
alias ll='ls -la'

# set options
set -u  # Treat unset variables as an error
# set -x  # Uncomment to enable debugging

# Special parameters
echo "Script name: $0"
echo "Number of arguments: $#"
echo "All arguments: $@"
