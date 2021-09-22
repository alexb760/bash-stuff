# Using `sed` command basic stuff.
`sed` command stand for Stream Editor that means we can use as text editor and strem files and modified base on
some basic criteria or some patern like regex.

## Further readings:
[Man sed Page](https://linux.die.net/man/1/sed)

## Some Flags used in this example.
 * `-E`: Enables extended regular expresion needed for `+` and grouping.
 * `-i` Edit file in plase if backup extension is defined will create one `-i.back`.
 * `/d` Deleted line if regex matches.
 * `s` substitude command.
 * `/ / /` Delimiters characters.
 * `/g` Replase all accurrences.
 * `\1 \2 \3` Back references, you can refere to any specif region of the regular expresion just indicating the nmb   er. if can start from 1 and whatever you need.

## Why `sed-move-and-modifying.sh`
  It will move some file from one directory to another directory, in the way to do so it will modify some file base  on some patterns we pretent to search in all the privided list of files `list-file-to-move.txt` and search the fo  llowing patterns.
   1. `sed -i '/@AwesomeAnnotation/d'` and delete that line.
   2. if the file contains the fallowing regex ` 'extends .+([1])'` (extends following to any character and ends in      1) then apply the following command `sed -E -i 's/(extends .+).$/\1/'` delinting last character in the matche      s pattern.

## How to run.

````shell
    cd sed-command/
    ./sed-move-and-modifying.sh
````

## More usefull examples on how to use `sed`
### Aampersand Reference `&`: Rerpresent the content of the matches pattern
    the pattern `[[:digit:]]` only match a single number.
````shell
   sed -e 's/^[[:digit:]][[:digit:]][[:digit:]]/(&)/g' phone.txt
   #expected output
   (123)6682530
   (571)4445230
````

### Using multiples command:
````shell
  sed -e 's/^[[:digit:]]\{3\}/(&)/g'  \ 
   -e 's/)[[:digit:]]\{3\}/&-/g' phone.txt 
   #Expected ouput.
   (555)555-1212 
   (555)555-1213
````

### Back References.
````shell
  cat phone.txt | sed 's/\(.*)\)\(.*-\)\(.*$\)/Area \ 
   code: \1 Second: \2 Third: \3/' 
   #Expected ouput.
   Area code: (555) Second: 555- Third: 1212 
   Area code: (555) Second: 555- Third: 1213
````

### Recursive find and replace.
````shelll
    find . -type f -exec sed -i 's/foo/bar/g' {} +
````
  1. Avoid files containing spaces in the names.
````shell
 find . -type f -print0 | xargs -0 sed -i 's/foo/bar/g'
````
  2. especific extension.
````shell
  find . -type f -name "*.md" -print0 | xargs -0 sed -i 's/foo/bar/g'
````
  3. Using `grep` to search recusive base on some pattern that the files may content.
````shell
 grep -rlZ 'foo' . | xargs -0 sed -i.bak 's/foo/bar/g'
````

