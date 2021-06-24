# Prolog for dummies
This is a repo meant to be studied before the final exam of exercises off the Declarative Programming course on Poznan University of Technology. You are however free to learn from it in any circumstances. But be informed that the professor teaching it disallows any built in predicates apart from `append`, `length`, `member`, and `not` (of which I will use mainly the first two) and the use of `;` in the predicate body. He also prefers one letter variables, and decided that despite leading also the `AI` course he shan't learn anything about ML and NN. 

The repo is intended to be cloned and viewed in some IDE (I recommend VS code).

## Compiler
I highly recommend the `Program` option on https://swish.swi-prolog.org/ everything is tested there, because I cba to set up local compiler when so good a resource exists online.

## Some facts you should know beforehand

* `[H|T]` - is a list of length `>= 1`, the first element becomes `H` and the rest of the list is in `T`. Some implications:
    * if the original list type is `Array<MyType>` - `H` is of type `MyType` and `T` is of type `Array<MyType>`
    * `T` can be an empty list
* `[H1,H2|T]` is a list of length `>= 2`, `[H1,H2,H3|T]` of length`>=3`, etc.
* `[[H1|[H2|T]]]` is equivalent to `[H1,H2|T]` but I sometimes forget
* Arithmetics are wacky and cannot be performed inside the header of the predicate, see `my_length` (idk how it will be named I write the readme beforehand).
    * To assign value to variable you must write something like this: `N1 is N + 1` where N is a variable the compiler knows the value of.
* `_` means a single variable that is not used anywhare else in this predicate but nevertheless exists, see `my_head`
* It is extremely important to supply subpredicates and arithmetics with predicates you are sure the compiler knows the value of. I try to explain this near `my_length`
    * The order of subpredicates and artihmetics in the 'body' of a predicate is important for this
* I try to explain the usage of `!` as best I can, but I am aware that I will not always be understandable.
    * In this tutorial it will always be the last thing in the body of a predicate. I know it can be used earlier for some magic, but remember the main purpose of the tutorial.
    * The rule of thumb is to use it if you want the compiler to stop at the predicate you use it in. see `my_last`  
    * It is important because prolog predicates work a bit like generator functions in python (those with `yield`) and prolog knows no `return` keyword
* I will try to supply each and every predicate with a test that can be run from the prolog cmd with `test_my_predicate(X)` (of course the number of variables to be supplied into the parentheses depends on the cardinality of predicate).
    * Apart from that you can also copy the test predicates body directly into console.


## FAQ

### What does the `+`, `-`, or, `?` before the argument of the predicate mean?
https://stackoverflow.com/a/4220776
https://stackoverflow.com/a/40824709

I will almost never use the `?`, although probably I should as my predicates could be used to check results as well, I might change this in the future.

### Which sorting algorithm should I learn?

Quick sort. Hands down the simplest (I know it's counterintuitive) and with least code overhead.

### Krucjata mapping 
```
1 - 009
2 - 010
3 - 012
4 - 011
5 - 013
6 - 014
9 - 015
```