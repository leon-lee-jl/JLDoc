****
Java
****
From Book "Data Structure and Algorithms in Java (Six Edition)"

.. contents:: Table of Contents
    :depth: 4


1. Java Primer
==============

1.1 Getting Started
-------------------

- //： Inline comment
- /* \*/: Block comment

Base (Primitive) types:

- boolean
- chart: 16-bit Unicode character
- byte: 8-bit signed two’s complement integer
- short: 16-bit signed two’s complement integer
- int: 32-bit signed two’s complement integer
- long: 64-bit signed two’s complement integer
- float: 32-bit floating-point number
- double: 64-bit floating-point number

Default integer type is "int", default number type is double.

A nice feature of Java is that when base-type variables are declared as
instance variables of a class (see next section), Java ensures initial
default values if not explicitly initialized. In particular, all numeric
types are initialized to zero, a boolean is initialized to false, and a
character is initialized to the null character by default.

1.2 Classes and Objects
-----------------------

Instance variables can be a base type ot any class type (also called a
reference type).

- accessor method: class method not changing instance variables
- update method: class method changing instance variables
- constructor: always share the same name of

