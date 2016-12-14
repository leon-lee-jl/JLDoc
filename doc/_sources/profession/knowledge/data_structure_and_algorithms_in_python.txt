*************************************
Data Structure & Algorithms in Python
*************************************
*By Michael T. Goodrich, Roberto Tamassia, & Michael H. Goldwasser*

.. contents:: Table of Contents
   :depth: 4

Chapter 1 Python Primer
=======================
Unlike Java and C++, Python is a dynamically typed language, as there is no advance declaration associating an identifier with a particular data type. Although an identifier has no de- clared type, the object to which it refers has a definite type.

A class is immutable if each object of that class has a fixed value upon instantiation that cannot subsequently be changed.

.. csv-table:: Python Common Used Built-in Classes
      :header: "Class", "Description", "Immutable?", "Structure"
      :widths: 30, 50, 50, 100

      "bool", "Boolean Value", "Yes", "-"
      "int", "Integer (Artitary magnitude)", "Yes", "-"
      "float", "floating-point number", "Yes", "-"
      "list", "mutable sequence of objects", "No", "[1,2,3,4,5 .....]"
      "tuple", "immutable sequence of objects", "Yes", "(1,2,3,4,5), like list, but immutable"
      "str", "character string", "Yes", "-"
      "set", "unordered set of distinct objects", "No", "{'red', 'green', 'blue'......}, without duplicates"
      "frozenset", "immutable form of set class", "Yes" "{'red', 'green', 'blue'}, like set, but immutable"
      "dict", "associative mapping (aka dictionary)", "No", "{'ga': 'Irish', 'de': 'German'}"


The syntax list( hello ) produces a list of individual characters, [ h , e , l , l , o ].

{ } does not represent an empty set; for historical reasons, it represents an empty dictionary.

"/" operator means true divison, keeping the floating-point part.
"//" operator means integer division, not keeping the floating-point part.

Built-in sequence types (str, tuple, and list) support the following operator syntaxes:

* s[j] element at index j
* s[start:stop] slice including indices [start,stop)
* s[start:stop:step] slice including indices start, start + step, start + 2 step, . . . , up to but not equalling or stop
* s+t concatenation of sequences
* k*s shorthand for s + s + s + ... (k times)
* val in s containment check
* val not in s non-containment check

Sets and frozensets support the following operators:

* key in s containment check
* key not in s non-containment check
* s1 == s2 s1 is equivalent to s2
* s1 != s2 s1 is not equivalent to s2
* s1 <= s2 s1 is subset of s2
* s1 < s2 s1 is proper subset of s2
* s1 >= s2 s1 is superset of s2
* s1 > s2 s1 is proper superset of s2
* s1 | s2 the union of s1 and s2
* s1 & s2 the intersection of s1 and s2
* s1 − s2 the set of elements in s1 but not s2
* s1 ˆ s2 the set of elements in precisely one of s1 or s2

Dictionary supported operators are as follows:

* d[key]  value associated with given key
* d[key] = value   set (or reset) the value associated with given key
* del d[key]  remove key and its associated value from dictionary
* key in d  containment check
* key not in d  non-containment check
* d1 == d2   d1 is equivalent to d2
* d1 != d2   d1 is not equivalent to d2

1.1 Control Flow
----------------
.. code-block:: Python

    if xxxx:
    elif yyy:
    elif zzz:
    else:

.. code-block:: Python

    while condition:
        body
.. code-block:: Python

    for element in iterable:
        body
    for j in range(len(data)):
        body

1.2 Built-in Functions
----------------------

1. print(a, b, c, sep= : )
2. reply = input( Enter x and y, separated by spaces: )
3. fp = open( sample.txt )
4. isinstance(obj, cls)
5. reversed(sequence)

1.3 Exception Handling
----------------------

.. csv-table:: **Common exception classes in Python**
      :header: "Exception", "Description"
      :widths: 30, 100

      "Exception", "A base class for most error types"
      "AttributeError", "Raised by syntax obj.foo, if obj has no member named foo"
      "EOFError",  "Raised if “end of file” reached for console or file input"
      "IOError", "Raised upon failure of I/O operation (e.g., opening file)"
      "IndexError", "Raised if index to sequence is out of bounds"
      "KeyError", "Raised if nonexistent key requested for set or dictionary "
      "KeyboardInterrupt", "Raised if user types ctrl-C while program is executing"
      "NameError", "Raised if nonexistent identifier used."
      "StopIteration", "Raised by next(iterator) if no element"
      "TypeError", "Raised when wrong type of parameter is sent to a function"
      "ValueError", "Raised when parameter has invalid value (e.g., sqrt(−5))"
      "ZeroDivisionError", "Raised when any division operator used with 0 as divisor"

Philosophies when managing exceptions:

1. Look before you leap. (check in advance to prevent the exceptions.)
2. It is easier to ask for forgiveness than it is to get permission.(implemented using a try-except control structure)

The relative advantage of using a try-except structure is that the non-exceptional case runs efficiently, without extraneous checks for the exceptional condition. How- ever, handling the exceptional case requires slightly more time when using a try- except structure than with a standard conditional statement. For this reason, the try-except clause is best used when there is reason to believe that the exceptional case is relatively unlikely, or when it is prohibitively expensive to proactively eval- uate a condition to avoid the exception.

It is permissible to have a final except-clause without any identified error types, using syntax except:, to catch any other exceptions that occurred.

A try-statement can have a **finally** clause, with a body of code that will always be executed in the standard or exceptional cases, even when an uncaught or re-raised exception occurs. That block is typically used for critical cleanup work, such as closing an open file.

1.4 Iterators and Generators
-------------------------------------
An iterator is an object that manages an iteration through a series of values.  "i = iter(data), next(i)"

A generator is implemented with a syntax that is very similar to a function, but instead of returning values, a **yield** statement is executed to indicate each element of the series.

It is illegal to combine yield and return statements in the same implementation, other than a zero-argument return statement to cause a generator to end its execution.

1.4 Conditional Expressions
---------------------------------------

.. code-block:: Python

    expr1 if condition else expr2
    expression for value in iterable if condition

Automatic packing of a tuple: One common use of packing in Python is when returning multiple values from a function. If the body of a function executes
the command, "return x, y", it will be formally returning a single object that is the tuple (x, y).

Python implements a namespace with its own dictionary that maps each identifying string (e.g., n ) to its associated value. Python provides several ways to examine a given namespace. The function, dir, reports the names of the identifiers in a given namespace (i.e., the keys of the dictionary), while the function, vars, returns the full dictionary.

In the terminology of programming languages, first-class objects are instances of a type that can be assigned to an identifier, passed as a parameter, or returned by a function.

.. csv-table:: **Python modules relevant to data structures and algorithms**
      :header: "Module Name", "Description"
      :widths: 30, 100

      "array" "Provides compact array storage for primitive types."
      "collections"  "Defines additional data structures and abstract base classes involving collections of objects."
      "copy"  "Defines general functions for making copies of objects."
      "heapq"  "Provides heap-based priority queue functions"
      "math"  "Defines common mathematical constants and functions."
      "os"  "Provides support for interactions with the operating system."
      "random"  "Provides random number generation."
      "re"  "Provides support for processing regular expressions."
      "sys"  "Provides additional level of interaction with the Python interpreter."
      "time"  "Provides support for measuring time, or delaying a program."

Pseudo-Random Number Generation, for applications, such as computer security settings, where one needs unpredictable random sequences, this kind of formula should not be used.

Chapter 2. Object-Oriented Programming
=======================================
Goals of object-oriented design:

* Robustness: capable of handling unexpected inputs that are not explicitly defined for its application.
* Adaptability: the ability of software to run with minimal change on different hardware and operating system platforms
* Reusability: the same code should be usable as a component of different systems in various applications.

Object-Oriented Design Principles:
* Modularity: refers to an organizing principle in which different components of a software system are divided into separate functional units
* Abstraction: distill a complicated system down to its most fundamental parts
* Encapsulation:



**Duck Typing**: no “compile time” checking of data types in Python, more interpretation can be found `here <http://bbs.fishc.com/forum.php?mod=viewthread&tid=51471>`_



Chapter 3. Algorithms Analysis
==============================


Chapter 4. Recursion
============================


Chapter 5. Array Based Sequence
=================================
