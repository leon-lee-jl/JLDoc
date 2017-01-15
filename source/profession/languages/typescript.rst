*******************************
TypeScript
*******************************
From Official `Documentation <https://www.typescriptlang.org]>`_

.. contents:: Table of Contents
    :depth: 4


1. Quick Start
===============
TypeScript features

- Type Annotation: Record the intended contract of the function or variable.
- Interfaces: Define complex data type.
- Classes: Support class-based object-oriented programming.

2. Tutorial
=================
Some useful Javascript libraries to collaborate with,

- Gulp: Build tool
- Browserify: Bundle all modules in nodeJS and enable it to run in browser.
- Babel: Convert ES2015 and beyond into ES5 and ES3.
- Uglify: Compact codes to speed up download.
- Watchify: Watch mode for Browserify builds.

3. Handbook
===============
Basic Types:

- Boolean: let isDone: boolean = false;
- Number: let decimal: number = 6; (0x for hex, 0b for binary, 0o for octal)
- String: let color: string = "blue";
- Array: let list: number[] = [1, 2, 3];
- Tuple: let x: [string, number]; x = ["hello", 10] (declare and then init the tuple)
- Enum: enum Color {Red, Green, Blue}; let c: Color = Color.Green;
- Any: Not sure of data type, e.g. let notSure: any = 4
- Void: Opposite of any: the absence of any type at all (You can only assign undefined and null to void variables)
- Null and Undefined: subtypes of all other types. When using the --strictNullChecks flag, null and undefined are only assignable to void and their respective types.
- Never: Represent the type of values that never occur.

.. hint::
    If using "setTimeout" in for loop, the setTimeout will only be executed multiple times (n defined in for loop) after all the loops are finished. One solution is to use IIFE (Immediately Invoked Function Expression), check `here <http://www.typescriptlang.org/docs/handbook/variable-declarations.html>`_

The act of introducing a new name in a more nested scope is called shadowing. Shadowing should always be avoided.

**let vs const**

All declarations other than those you plan to modify should use const. Using const also makes code more predictable when reasoning about flow of data.

3.1 Interfaces
****************
In typescript, interfaces fill the role of naming types, and are a powerful way of defining contracts within code as well as contracts with code outside project.

**Optional Properties**

.. code-block:: typescript

    interface A {
        color?: string;
        width?: number
    }

**Readonly properties**

.. code-block:: typescript

    interface Point {
        readonly x: number;
        readonly y: number;
    }

**Excess Property Checks**

Typescript will perform excess property checks when extra properties are assigned in function call. To escape property check, we can use type assertion.

.. code-block:: typescript

    let mySquare = createSquare({ width: 100, opacity: 0.5 } as SquareConfig);

Or define in interfaces.

.. code-block:: typescript

    interface SquareConfig {
        color?: string;
        width?: number;
        [propName: string]: any;
    }

Or assign the object to another variable.

.. code-block:: typescript

    let squareOptions = { color： "red"; width: 100; };
    let mySquare = createSquare(squareOptions);


**Function Type**

Define function type with interface:

.. code-block:: typescript

    interface SearchFunc {
        (source: string, subString: string): boolean;
    }

Or define in function definition.

**Indexable Types**

Describe types that we can "index into" like a[10], or ageMap["daniel"]. There are two type of index signature, string and number. But the type returned from a numeric indexer must be a subtype of the type returned from the string indexer.

.. code-block:: typescript

    interface StringArray {
        [index: number]: string;
    }


**Class Types**
