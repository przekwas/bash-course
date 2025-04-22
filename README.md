
# Intro

### What is a Shell?
A program that interprets the commands you type in your terminal and passes them onto the operating system.
- Makes it more convenient for users to issue commands to the computer
- Bash = Bourne Again SHell  
  - Based on Bourne Shell (sh), created in '79
- Feature-rich, fast, very common

### What is a Script?
A shell script, or script, is a file containing a series of commands for the shell. A Bash script is just one written for this particular shell.
- Allows automation, save time, and increase reliability

# Structure of Bash Scripts

### Core Components

Shebang line is the very first line of a script. Tells the shell what language the script will be written in.
- `#!/bin/bash`  
  - hash bang a.k.a. shebang  
  - path to bash shell or language right after  
  - 2 new lines below it
- `file path/to/file` tells us what kind of file it is
- `echo` outputs to shell
- `exit` statement  
  - tells shell the script has ended  
  - different codes for success or fail  
    - 0-255  
    - 0 is clean exit  
    - 1 is a general error
- execute permissions required in most OS  
  - `chmod +x name_of_file`  
    - should change color of file if it has permissions

#### TL;DR
- Beginning  
  - shebang line
- Middle  
  - Commands
- End  
  - Exit statement 

### Professional Components

- Commenting  
  - `#` is the syntax in bash/zsh  
  - Author written typically beneath the shebang line  
  - Date Created  
  - Last Modified  
  - Description  
  - Usage

### Script Security

Who can perform certain actions on certain files.
- `ls -l`
- In Linux, file permissions are represented by 10 characters strung together
- First character stands alone, and the next 9 are 3 sets of 3
- First Char  
  - `-` entry is a file  
  - `d` entry is a directory
- Next set of 3 Char represent permissions of files owner has for file  
  - First char in set is read permissions  
    - `r` entry is read permission, `-` otherwise  
  - Second char in set is write permissions  
    - `w` entry is write permission, `-` otherwise  
  - Third char in set is execute permissions  
    - `x` entry is execute like a script, `-` otherwise
- The next 2 sets of 3 Chars follow the same format, but for different classes of users  
  - The second set is the files group  
  - The third set is every other user on system

Common security is only file owner can write, where everyone else can only read. Also only file owner can run a script, and nobody else.
- `chmod 744 file_name`  
  - `744` is an octal number, use https://chmod-calculator.com/ to generate them

#### TL;DR Other OS's
| Feature               | Linux/macOS Terminal | Windows           | macOS GUI                  |
| --------------------- | -------------------- | ----------------- | -------------------------- |
| Permission string     | `-rwxr-xr--`         | ❌                 | ❌                          |
| Uses ACLs             | ✅ (advanced)         | ✅                 | ✅                          |
| GUI-based permissions | ❌ (by default)       | ✅                 | ✅                          |
| CLI tools             | `chmod`, `chown`     | `icacls`, `cacls` | `chmod`, `chown`, `ls -le` |

### Adding scripts to your PATH
The systems PATH is a variable that tells the shell which directories to search for executable files in. This is why I'd point shit to `/bin`'s around my machine for coding stuff.
- System's path edited via `~/.profile` file  
  - Config details for the bash shell, reads on start up  
  - This is `~/.zshrc` in Zsh oh my god lol

# Variables and Shell Expansions

A parameter is any entity that stores values. A value that you can store and change, basically. Three different types:
- Variables (most common)
- Position params
- Special params

### Variables

User Defined variables and Shell Defined variables:
- lowercase for user, uppercase for shell
- `name=value` note the no spaces around the `=` operator
- `${}` causes shell to look for that parameter and puts in the entire value in place called parameter expansion

### Shell Variables

- Bourne Shell variables  
  - 10 in total
- Bash Shell variables  
  - around 95 in total

No need to memorize, but a lot you get used to using regularly.

- Bourne Shell examples  
  - `PATH` contains list of folders that the shell will search left-to-right for executable files to run as command names  
    - `echo ${PATH}` or `echo $PATH`  
      - curlies not needed for simple param expansion like just seeing a value of a variable  
  - `HOME` used to store the absolute path to current user's home directory  
  - `USER` contains username of the current user  
  - `HOSTNAME` and `HOSTTYPE`  
    - type can be useful for a script to install different packages depending on machine e.g. 32 or 64 bit systems  
  - `PS1` prompt string 1  
    - changes the color and stuff of the prompt line e.g. what my zsh and oh-my-zsh customize!

### Parameter Expansion Tricks

While variables can be used just like `$name` if you do the curlies you get parameter expansion tricks in your shell `${name}`

| Zsh Syntax   | Description                   | Example (`name="HELLO"`) | Zsh Output | Bash Equivalent | Bash Output |
| ------------ | ----------------------------- | ------------------------ | ---------- | --------------- | ----------- |
| `${name:l}`  | Lowercase **first** character | `${name:l}`              | hELLO      | N/A             | N/A         |
| `${(L)name}` | Lowercase **all** characters  | `${(L)name}`             | hello      | `${name,,}`     | hello       |
| `${name:u}`  | Uppercase **first** character | `${name:u}`              | HELLO      | N/A             | N/A         |
| `${(U)name}` | Uppercase **all** characters  | `${(U)name}`             | HELLO      | `${name^^}`     | HELLO       |

- `${#name}` gives the length of your variable
- **Slicing**  
  - `${parameter:offset:length}`  
    - no length provided bash will assume we want everything after the offset  
    - you can do a negative offset `${parameter: -offset:length}`  
      - ***MUST PROVIDE A SPACE AFTER THE FIRST COLON AND THE NEGATIVE SYMBOL***
  - like `.slice(index, len)` in JS  
  - counts at `0` thankfully

### Command Substitution

Probably the most used thingy we're gonna learn. Can save output of commands in variables, or use output of one command inside another command, wow!

Syntax
- `$(command)` instead of curlies
	- kinda like returning a value from another function into a variable in JS
		- `let name = `getName();`

### Arithmetic Expansion

Do all my usual arithmetic including programming stuff like modulation, and learn the order of precedence of the operators.

Syntax
- `$((expression))`
	- arithmetic expansion doesn't need `$` symbol in front of variables as a shorthand
	- PEMDAS seems to still apply with parentheses being the highest order
	- `**` exponent shorthand
	- `%` remainder output
- can't provide decimal numbers, we use `bc` for that

#### The `bc` Command

This handles mathematical expressions that require decimal values in scripts, and can handle how many decimal places as needed.  It means "basic calculator" which is a programming language in and of itself.

- has internal "scale" value for how many decimal places to output
- can use `|` pipe operator to pipe an expression directly to the `bc` command
	- `echo "5/2" | bc` gives **2** cause of *no scale*
	- `echo "scale=2; 5/2" | bc` gives **2.50**
- uses `^` instead of `**` for exponents, though.  GL remembering idiot lol.

### Tilde Expansion

Refers to current user's home directory `~`, nifty.  For example we can `~username` to see if it prints a different users home directory and not mine.

- `$PWD` print working directory
	- `~+` is the shorthand equivalent
- `$OLDPWD` is last directory you were in
	- `~-` is the shorthand equivalent

### Brace Expansion

Generate sequences of text that follow a pattern e.g. folder shenanigans.

Syntax
- `{}`just a single set of curlies
	- String and Range lists
- `{param1,param2,param3,paramX}` string list is comma separated values, no spaces between
- `{param1..paramX}` range list is two dot between a range of values or letters
	- `{param1..paramX..step}` step allows us to control the sequence
	- `string{param1..paramX}` appends string to the expanded range
	- leading zeroes can be added as a nifty feature `month{01..12}`
	- can use paths and combinations for super powers!
		- `month{01..12}/day{01..31}.txt`
			- goes to each folder we made and makes 31 txt files in each dir


# How Bash Processes Command Lines

Does a lot of specific steps in the background that look different than the command I provide it.  So we needa' learn a little bit of how it works behind-the-scenes.

### Quoting

It is about removing special meanings.  The `$` symbol is used to tell the shell that an expansion is gonna happen.  So a `"$"` tells it to interpret it literally.
- `\` removes from next char
- `''` removes from all chars inside
- `""` removes from all except `$` and `` ` ``

Can help you influence where and when Tokenization happens in the process.

### Step 1: Tokenization

Shell receives the command line (from script or written by me) and it breaks it into tokens.  A sequence of chars that is interpreted as a "single unit" by the shell.  Uses metacharacters like we use punctuation in a sentence.  Tokens come as words and operators.
- **metacharacters**: 
	- `| & ; () <> space tab newline`
		- like punctuation in a sentence
- **word**: a token that does not contain an unquoted metacharacter
- **operator**: a token that contains at least one unquoted metacharacter
	- **control**: control how a command line is processed
	- **redirection**: tell the shell to redirections of data streams connected to a command

The two operator types only matter if they are *unquoted*.  
- `echo $name > out.txt`
	- 3 spaces are meta's
	- 1 `>` is another
		- so 4 metacharacters total
	- 3 words `echo`, `$name`, and `out.txt`
	- 1 redirection operator `>`

### Step 2: Command Identification

Shell breaks command line into simple or compound commands.  Simple like `echo, tar` and etc.
- **Simple**: commands are just bunch of individual words, and each simple command is terminated by a control operator
	- `echo 1 2 3`
		- `echo` command name
		- `1 2 3` 3 individual arguments provided to the simple command name
	- `echo 1 2 3 echo a b c` no control operator
		- outputs `1 2 3 echo a b c` because it's interpreted as a single line and the 2nd echo is a word with no meaning
	-	`echo 1 2 3;echo a b c` has a control operator so it's interpreted as two commands
		-	`1 2 3` and then `a b c`
- **Compound**: commands that provide bash programming constructs, such as `if` statements, `for` loops, `while` loops, and etc.
	- each compound command starts with a reserved word and is terminated by a corresponding reserved word
	- they can be written over multiple lines

### Step 3: Shell Expansions

All our expansions we've seen and others we haven't seen yet.  It has 4 stages the shell goes through when performing them.  Does these on the **words** processed from tokenisation.  

&nbsp;

- Stage 1: Brace Expansion
- Stage 2: Parameter, Arithmetic, Command Substitution, Tilde Expansion
- Stage 3: Word Splitting
- Stage 4: Globbing

&nbsp;

- These stages are done in descending order.

```bash
x=10
echo {1..$x}
```

- this won't work because brace expansion will happen before parameter expansion so bash won't know how to expand to `x`
- At the same stage, expansions are done in order from left to right as the shell reads them. 

Good knowledge trick question:
```bash
name=file
echo $name{1..3}.txt
```
- because the brace expansion happens first, the shell gets `echo $name1.txt $name2.txt $name3.txt`, which aren't valid parameters

#### Word Splitting Stage

This is a process the shell performs to split the result of some unquoted expansions into separate words.  Has significant effects on how command lines are interpreted.
- only performed on the results of **unquoted**:
	- parameter expansions
	- command substitutions
	- arithmetic expansions
- BURN THE ABOVE IN YO HEAD!!
- IFS (Internal Field Separator) are the characters used to split words (kinda like metacharacters in tokenisation)
	- *space, tab, and new line* by default
```bash
numbers="1 2 3 4 5"
touch $numbers
ls
# 1 2 3 4 5
rm {1..5}
```
- because they have a space, an ifs, it passes 5 individual words to the touch command
```bash
numbers="1 2 3 4 5"
touch "$numbers"
ls
'1 2 3 4 5'
```
- because word splitting on happens on unquoted, this will result in just 1 file by that name unlike above
- IFS is just a variable, so we can add stuff to it e.g. `IFS=","`

Simple rule, if you want the output of a:
- Parameter Expansion
- Arithmetic Expansion
- A Command Substitution

to be considered a single word, **WRAP IT IN DOUBLE QUOTES**

#### Globbing

- Originates from the "glob" program present in early versions of Bell Lab's Unix OS in 1969-1975
- Globbing is used as a shortcut for listing the files that a command should operate on
- Globbing is only performed on words, not operators
- Globbing patterns are words that contain *unquoted* **special pattern characters**
	- `*` `?` `[`
	- the pattern will be replaced by the alphabetically sorted list of the matching files to the globbing pattern
	- the `*` matches any characters, does not require a character to replace it, it is happy to match emptiness
	- the `?` matches any single character, just one
	- the `[]` are strict in length and a single character replace, but only match the characters inside the brackets, it's like a more precise `?` pattern
		- allows us to express ranges of characters, and we can daisy chain multiple brackets together e.g. `[abc][abc][abc]`
		- `[0-9]` or `[a-j]` the hyphen express a range, and it is case sensitive
		- `ls 99[0-9]` is tricky, but matches files 990 to 999

### Step 4: Quote Removal

We often add quotes to control how the command is interpreted, so this step simply removes all the supportive quotes.  Three types of quotes:
- `\`
- `''`
- `""`

During quote removal, the shell removes all *unquoted* backslashes, single quote characters, and double quote characters that did **NOT** result from a shell expansion.

```bash
❯ echo \$HOME
$HOME
❯ echo $HOME
/home/luke
❯ echo '\$HOME'
\$HOME
```

[after this you haven't formatted yet]


### Step 5: Redirections

### Data Streams

Every command executed in a shell interacts with three main data streams:

-   **Standard Input (stdin, Stream 0)**  
    This is how commands receive input data. It can come from the keyboard, a file, or output from another command.
    
-   **Standard Output (stdout, Stream 1)**  
    The default stream where commands send their successful output.
    
-   **Standard Error (stderr, Stream 2)**  
    The stream where commands send error messages or status messages.
    

----------

### Common Redirection Operators

Redirections allow you to change the default flow of these streams:

#### 1. `>` (Standard Output Redirection)

Redirects the standard output of a command to a file, **overwriting** existing content:

```bash
ls > files.txt

```

-   **Effect:** Writes the list of files in the current directory to `files.txt`. If `files.txt` exists, it is overwritten.
    

#### 2. `2>` (Standard Error Redirection)

Redirects the standard error stream to a file:

```bash
ls nonexistent_directory 2> errors.txt

```

-   **Effect:** Writes the error message (directory not found) into `errors.txt`.
    

#### 3. `&>` (Standard Output and Error Combined)

Redirects both stdout and stderr to a file, overwriting existing content:

```bash
ls real_dir nonexistent_dir &> all_output.txt

```

-   **Effect:** Writes both the successful outputs (real_dir listing) and the errors (nonexistent_dir error) into `all_output.txt`.
    

#### 4. `/dev/null` (Bitbucket)

A special file (`/dev/null`) that discards all data written to it—effectively deleting it immediately:

```bash
ls nonexistent_dir &> /dev/null

```

-   **Effect:** The command produces no visible output; any errors or output are silently discarded.
    

#### 5. `>>` (Append Standard Output)

Redirects the standard output of a command to a file, but **appends** to existing content instead of overwriting it:

```bash
echo "Log entry at $(date)" >> logfile.txt

```

-   **Effect:** Adds the date to the end of `logfile.txt`, preserving previous content.
    

#### 6. `2>>` (Append Standard Error)

Redirects the standard error stream to a file, appending errors to existing content:

```bash
ls nonexistent_dir 2>> error_log.txt

```

-   **Effect:** Adds any new error messages to the end of `error_log.txt`.
    

#### 7. `&>>` (Append Standard Output and Error)

Redirects both stdout and stderr to a file, appending to existing content:

```bash
ls real_dir nonexistent_dir &>> all_logs.txt

```

-   **Effect:** Both the standard output and error streams are appended to `all_logs.txt`.
    

----------

### Practical Examples & Patterns

**Example 1: Simple stdout redirection**

```bash
cat notes.md > output.txt

```

**Example 2: Discarding errors**

```bash
grep "search_text" *.md 2> /dev/null

```

**Example 3: Appending logs**

```bash
echo "Backup started at $(date)" >> backup.log

```

**Example 4: Separating success and errors**

```bash
command > output.log 2> error.log

```

**Example 5: Everything into one log**

```bash
command &> combined_output.log

```

----------

### Why Redirections Matter:

-   **Automation and Scripting:**  
    Essential for scripts that run automatically and must log outputs/errors.
    
-   **Error Management:**  
    Helps debug scripts by clearly separating successful output from error messages.
    
-   **Silent Operations:**  
    Useful in automation where outputs/errors should be hidden to keep scripts tidy.

### Execute!

Execute what is left over after all 5 previous steps are finally gone through.

## Example Commands Walkthrough

**Original Command:**

```bash
name="simon.smith"
out="output.txt"

echo $name > $out

```

### Step-by-Step Analysis

**Step 1: Tokenisation**

-   Identify words and operators by splitting the command line input.
    
-   Tokens:
    
    -   Words: `echo`, `$name`, `$out`
        
    -   Operator: `>` (output redirection)
        

**Step 2: Command Identification**

-   Determine the type of command from the tokens.
    
-   Identified as a simple command:
    
    -   `echo` (the command itself)
        
    -   `>` is identified as a redirection operator, not a control operator.
        

**Step 3: Expansions**

-   Perform expansions (parameter, command substitution, arithmetic, tilde, brace expansions).
    
-   In this command:
    
    -   Parameter Expansion occurs:
        
        -   `$name` → `simon.smith`
            
        -   `$out` → `output.txt`
            
     -  Word Splitting: None (expanded values contain no whitespace or special delimiters).
    -   No globbing occurs (no patterns or wildcards to expand).

        
-   Expanded result:
    
    ```bash
    echo simon.smith > output.txt
    
    ```   

**Step 4: Quote Removal**

-   Remove quotes around tokens, if present.
-   No quotes to remove in this expanded command.
    

**Step 5: Redirection**

-   Process any I/O redirections.
-   `>` redirects standard output (`stdout`) of the command (`echo simon.smith`) into the file `output.txt`.
    

### Final Execution

-   The command executes, resulting in the text `simon.smith` being written to the file named `output.txt`.


### Bash Command Processing Stepd
1.  **Tokenisation**
    -   Split input into words and operators.
2.  **Command Identification**
    -   Recognize command types (simple, pipeline, compound).
    -   Identify control operators.
3.  **Expansions**
    -   Brace (`{1..5}`)
    -   Sub in LTR order:
	    -   Parameter (`$var` or `${var}`)
	    -   Command substitution (`$(command)`)
	    -   Arithmetic (`$((expression))`)
	    -   Tilde (`~`)
	    -   Word splitting (ISF splits) of unquoted results of expansions/subs
    -   Globbing (`*`, `?`, `[abc]`)
4.  **Quote Removal**
    -   Remove any remaining quotes.
5.  **Redirection**
    -   Apply I/O redirections (`>`, `<`, `>>`, etc.)
6.  **Execution**
    -   Run the final processed command.


## Requesting User Input

### Positional Parameters

Shell assigns numbers to each positional parameter.  
	- `$1`, `$2`, and etc.
	- If you have positions that get to double digits e.g. 10 and higher, you can't use shorthand syntax you have to write the advanced expanded param syntax `${10}`
```bash
# positonal-script example
echo "My name is $1"
echo "My home directory is $2"
echo "My favorite color is $3"

./positional-script luke $HOME green
My name is luke
My home directory is /home/luke
My favorite color is green
```

`${param:-word}` is a fallback substitution.  If param is non-existent then word is substituted

### Special Parameters

Parameters that bash gives special meaning to.  Similar to shell variables, but special params cannot be changed in value. They are calculated for us based on what is happening in our current script.  They provide shortcuts to handy information.`$#` and `$0` special params.  Their meanings can change based on context, though.
- `$#` the number of positional params that have been provided to the script
- `$0` expands to name of current shell, but if in script it expands to name of script

These are a bit more tricky special parameters.  Special meanings when wrapped in double quotes, too.
- `$*`
	- exactly the same as unquoted `$@`
- `"$*"` 
	- places the first IFS character between each positional parameter
		- `IFS=, $1,$2,$3...,$N`
- `$@`
	- access all positional parameters in our script with spaces
	- `$1 $2 $3...$N`
	- each is considered its own word
- `"$@"` in quotes is different
	- `"$1" "$2" "$3"..."$N"` 
		- it avoids word splitting because it will now output all positional params in double quotes

### Read Command

Read command executes and pauses script until input is received.  It can be saved in a variable to be used later in the script, too.  By default it is saved as `$REPLY` by default.
```bash
read
# $REPLY

read name age
# $name $age

read -p "your town: " town
# prompts your town: $town

read -t 5 pizza
# prompts for $pizza but moves the script on after time in seconds

read -s password
# prompts for $password and keeps the text hidden from terminal, but it is still stored as plaintext in bash

read -N 4 code
# prompts $code with a max char limit of 4 regardless of delimiter early press, it's instead read as a char
```

### Select Command

Like read, but provides users a selection of inputs to choose from and saves the output into a variable for us to use.  It will by default format the select options in a numbered list e.g. 1) x 2) y 3) z and expects "1" or "2" or "3".  If the user selects an invalid option it simply reports an empty value.  It will infinitely loop in the command until "Control C" is pressed or coded to stop.

`PS3` variable is specifically for the prompt select

```bash
select in 1 2 3 4 5; do
	# $RESPONSE
	break
done

select topping in veggie meat sauce cheese; do
	# $topping which will be 1 of veggie meat sauce cheese
	break
done

PS3="Pick a pizza topping: "
select topping in veggie meat sauce cheese; do
	# prompts "Pick a pizza topping: " instead of #?
	# $topping which will be 1 of veggie meat sauce cheese
	break
done
```

# Logic

*List* of commands is created when you put one or more commands on a given line.  Even 1 line commands are considered lists in bash.  **List Operators** are types of control operators that enable us to create lists of commands that operate in different ways. (`& ; && ||`).

-   `&` allows us to run commands asynchronously.  Sends the preceding command into the background and notified when it's completed via id number.  
-   `;` runs commands sequentially.  Command 1 to completion -> then command 2 to completion -> etc.  Saves space rather than using multiple lines in a script.
    -   Will continue lines even if first command fails.
-   `&&` runs second command in list *only* if the first one was successful.  
-   `||` runs second command in list *only* if the first one failed.

Think of the latter two as kinda like what you know as a JS short circuit.  You can mix all the list operators together to make what they call a "ternary" operator in bash scripts.


```bash
commandA && commandB || commandC
```

-   `commandA` will attempt to complete
    -   if it fails, the `||` will run `commandC`
    -   if it succeeds, the `&&` will run `commandB` afterward

# Test Commands and Conditional Operators

Logical checsk with scripts, and foundational to `if` statements as well.  A *test command* is a command that can be used in bash to compare different pieces of information.  A status code exit `0` if a test evaluates as true, if false then returns a `1`.  
-   written in a set of `[ ]` and note the space between the square brackets is NEEDED for it to run correctly.
    -   `[ 2 -eq 2 ]` is 2 equal to 2
    -   `[ 2 -eq 2 ] ; echo $?` gets the exit status of the last command
-   INTEGER number checks, doesn't work on decimals.
    -   `-eq` equal to
    -   `-ne` checks if integer is *not* equal to another
    -   `-gt` greater than
    -   `-lt` less than
    -   `-geq` greater than or equal to
    -   `-leq` less than or equal to
- STRING test operators
  - `=` checks if strings are equal
  - `!=` checks if strings are not equal
  - `-z` checks if string is empty
    - `[ -z $c ] ; echo $?` checks if the `$c` variable is an empty or null string
  - `-n` checks if string length is not 0

File Test Operators compare files.  
- `[[ -e today.txt ]] ; echo $?` checks if a file exists
- `-f` checks if something exists and is a regular file e.g. a word, txt, or pdf file type.
- `-d` checks if something exists and is a directory
- `-x` checks if file exists and has execute permissions
- `-r` `-w` checks if file is readable, writeable, etc.

# If Statements in Bash

They are a type of compound commands (like using reserved words).  These reserved words are `if` and `fi` for if statements in bash.  They check the exit status of a command given to the check.

```bash
if [ test ]; then
  command if passed
fi
```

- `if` starts the statement and is a reserved word for bash to determine this a compound command
- `[ test ]` is our test operator segment to see if the command inside results in a status `0` for true and `1` for false
- `;` this tells our shell that we finished writing the condition commands and what follows are what we run to if it's true
- `then` + a new line is the consequence commannds if the test passes, typically tabbed/indented in for readability but not required
- `fi` ends the statement with this reserved word

```bash
if [ test ]; then
  command if passed
else
  command if failed
fi
```

- `else` runs alternate commands if the condition above it is not true aka a non-zero exit status

```bash
if [ test ]; then
  command if passed
elif [ test2 ]; then
  command if 2nd passed
else
  command if failed
fi
```

- `elif` allows us to check another condition if the first one fails

Three Important Notes:
- you cannot put an `elif` after an `else`
- there is no limit to the amount of `elif` statements you can have
- you can put `if` statements inside other `if` statements

### Chaining Commands

Chaining commands chain together multiple test constructs to create more powerful conditions/logic.  

```bash
a=$(cat file1.txt)
b=$(cat file2.txt)
c=$(cat file3.txt)
if [ $a = $b ] && [ $a = $c ]; then
    rm file2.txt file3.txt
else
    echo "Files do not match"
fi
```
- `&&` logically chains first succesful test into the second