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
- constructor: always share the same name of as its class

**The Dot Operator:**

- A method name combined with the number and types of its parameters is called a method's signature.

- There can be many references to the same object.

**Defining a Class:**

- public class modifier: all classes may access the defined aspect
- In java, each public class must be defined in a separate file named classname.java, where "classname" is the name of the class.
- protected class modifier: access to the defined aspect is only granted to the following groups of classes, subclasses and classes belong to the same package
- private class modifier: access to a defined member of a class be granted only to code within that class
- If no explict access control modifier is given, he defined aspect has "package-private" level, allowing other classes in the same package to have access
- static: define variable or methods in class. static variable is associated with class as a whole, storing global information about a class. Static method is associated with class itself, which means the method is not invoked on a particular instance of the class using the traditional dot notation, it is invoked using the name of the class as qualifier (E.g., Math.sqrt(2))
- abstract: declare method, whose signature is provided but without an implementation of the method body.
- A class with one or more abstract methods must also be formally declared as abstract, because it is essentially incomplete.
- final: a variable with final modifier can be initialized as part of that declaration, but can never again be assigned a new value. A final method can't be overridden by a subclass, and a final class can't even be sub-classed.

**Declaring Instance Variables format:** [modifier] type identifier = initialValue

**Declaring Methods format:** [modifier] returnType methodName(type1 param1, ...) {}

Java methods can return only one value. To return multiple values in Java, we should instead combine all the values we want to return in a compund object, whose instance variables include all the values we want to return, and then return a reference to that compound object. In addition, we can change the internal state of an object that is passed to a method as another way of "returning" multiple results.


**Declaring Constructors:**

- cant't be static, abstract, or final, can only be public, protected, or private
- name of constructor must be the same with class name
- no return type declaration, nor return value (even void)
- A class can have many constructors, but each must have a different signature
- default constructor, zero arguments and all instance variables initialized to their default values

**The Keyword this:**

- With the body of a non-static method, keyword "this" is automatically defined as a reference to the instance upon which the method was invoked.
- "this" can use to invoke other constructors

**The main Method:**

- The primary control for an application in Java must begin in some class with the execution of a special method named main, defined public static void main(String[] args) { }

1.3 Strings, Wrappers, Array, and Enum Types
--------------------------------------------
**String class**:

- A string instance represents a sequence of zero or more characters
- character indexing: from 0 to n-1, n is the length of the string, e.g. String.charAt(9)
- concatenation (combing string), e.g. "A" + "B", it does create a new string, copying all characters of the existing string in the process, time consuming
- String class instance is immutable, once the instance is created and initialized, the value of the instance cannot be changed.
- String is reference type, so the String variable can be reassigned to anther String instance.

**StringBuilder class:**

- mutable version of string


**Wrapper Types:**

- Java defines a wrapper class for each base type
- Automatic Boxing and Unboxing: converting between base types and their wrapper types

.. image:: ../../_static/java_wrapper_type.jpeg
      :height: 600px
      :width: 600px
      :alt: Git file lifecycle
      :scale: 100 %
      :align: center

**Arrays:**

- array elements: from 0 to n-1, n is the array length, e.g. a[k]
- variables of an array type are reference variables, e.g. int[] primes = {1, 2, 3} or new int[3]
- When arrays are created using the new operator, all of their elements are automatically assigned the default value for the element type

**Enum Types:**

- types that are only allowed to take on values that come from a specified set of names
- e.g. public enum Day {MON, TUE, WED, THU, FRI, SAT, SUN}
- modifier can be blank, public, protected, or private, name values are usually capitalized.


1.4 Expressions
---------------
**Literals:**

- A literal is any “constant” value that can be used in an assignment or other expression.

**Operators:**

- ++i or i++ enabled
- !, &&, || for boolean values
- bitwise operators, ~, &, |, ~, <<, >>, >>>
- Operators on the same line are evaluated in left-to-right order (except for assignment and prefix operations, which are evaluated in right-to-left order)

**Type Conversions:**
- explict casting: (type) exp
- implict casting: you can perform a widening cast (int to double) without use of casting operator
- Incidentally, there is one situation in Java when only implicit casting is allowed, and that is in string concatenation.

1.5 Control Flow
----------------

.. code-block:: java

    if () {
        body
    }
    else if {
        body
    }
    else {
        body
    }


.. code-block:: java

    switch(d) {
        case MON:
            statements;
            break;
        case TUE:
            statements;
            break;
        default:
            statements;
    }


.. code-block:: java

    do {
        statements;
    } while (A);

    while (A) {
        statements;
    }


.. code-block:: java

    for (int j=0; j < data.length; j++) {
        statements;
    }


**For-each loop:**

.. code-block:: java

    for (double val : data) {
        statements;
    }