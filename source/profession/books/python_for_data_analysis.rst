***************************************
Python for Data Analysis
***************************************
*By Wes McKinney*

.. contents:: Table of Contents
   :depth: 4



Chapter 0. Preface
=====================

Chapter 1. Preliminaries
=========================


Chapter 2. Introductory Examples
=================================


Chapter 3. IPython: An Interactive Computing and Development Environment
==========================================================================
* ***?*** : before or after a variable will display some general information about the object, it also has a final usage, which is for searching the IPython namespace in a manner similar to the standard UNIX or Windows command line.
* ***%run*** : run a python script, Should you wish to give a script access to variables already defined in the interactive IPython namespace, use %run -i instead of plain %run.
* ***??*** : will also show the function’s source code if possible
* ***%xmode*** : command to show verbose or less trace context
* ***ipython --pylab*** : First IPython will launch with the default GUI backend integration enabled so that matplotlib plot windows can be created with no issues. Secondly, most of NumPy and matplotlib will be imported into the top level interactive namespace to produce an interactive computing environment reminiscent of MATLAB and other domain-specific scientific computing environments. It’s possible to do this setup by hand by using %gui, too (try running %gui? to find out how).
* ***<Ctrl-R*** : gives you the same partial incremental searching capability provided by the readline used in UNIX-style shells ***_27 for the 27th line output, and _i27 for the 27th line input***
***%pdb*** : command makes it so that IPython automatically invokes the debugger after any exception

Paste code to execute on ipython terminal: Use the %paste and %cpaste magic functions. %paste takes whatever text is in the clipboard and executes it as a single block in the shell; %cpaste is similar, except that it gives you a special prompt for pasting code into.


%timeit is average time of a statement by running the statement multiple times, while %time just run the statement once.

As a general rule of thumb, I tend to prefer %prun (cProfile) for “macro” profiling and %lprun (line_profiler) for “micro” profiling. It’s worthwhile to have a good understanding of both tools.


.. csv-table:: Standard IPython Keyboard Shortcuts
      :header: "Command", "Description"
      :widths: 30, 350

      "Ctrl-p or up-arrow",	"Search backward in command history for commands starting with currently-entered text"
      "Ctrl-n or down-arrow", "Search forward in command history for commands starting with currently-entered text"
      "Ctrl-r",	"Readline-style reverse history search (partial matching)"
      "Ctrl-Shift-v", "Paste text from clipboard"
      "Ctrl-c",	"Interrupt currently-executing code"
      "Ctrl-a",	"Move cursor to beginning of line"
      "Ctrl-e",	"Move cursor to end of line"
      "Ctrl-k",	"Delete text from cursor until end of line"
      "Ctrl-u",	"Discard all text on current line"
      "Ctrl-f",	"Move cursor forward one character"
      "Ctrl-b",	"Move cursor back one character"
      "Ctrl-l",	"Clear screen"



.. csv-table:: Frequently-used IPython Magic Commands
      :header: "Command", "Description"
      :widths: 100, 350

      "%quickref", "Display the IPython Quick Reference Card"
      "%magic", "Display detailed documentation for all of the available magic commands"
      "%debug", "Enter the interactive debugger at the bottom of the last exception traceback"
      "%hist", "Print command input (and optionally output) history"
      "%pdb", "Automatically enter debugger after any exception"
      "%paste", "Execute pre-formatted Python code from clipboard"
      "%cpaste", "Open a special prompt for manually pasting Python code to be executed"
      "%reset", "Delete all variables/names defined in interactive namespace"
      "%page OBJECT", "Pretty print the object and display it through a pager"
      "%run script.py", "Run a Python script inside IPython"
      "%prun statement", "Execute statement with cProfile and report the profiler output"
      "%time statement", "Report the execution time of single statement"
      "%timeit statement", "Run a statement multiple times to compute an emsemble average execution time. Useful for timing code with very short execution time"
      "%who, %who_ls, %whos", "Display variables defined in interactive namespace, with varying levels of information/verbosity"
      "%xdel variable", "Delete a variable and attempt to clear any references to the object in the IPython internals"


.. csv-table:: IPython system-related commands
      :header: "Command", "Description"
      :widths: 100, 350

      "!cmd", "Execute cmd in the system shell"
      "output = !cmd args", "Run cmd and store the stdout in output"
      "%alias alias_name cmd", "Define an alias for a system (shell) command"
      "%bookmark", "Utilize IPython’s directory bookmarking system"
      "%cd directory", "Change system working directory to passed directory"
      "%pwd", "Return the current system working directory"
      "%pushd directory", "Place current directory on stack and change to target directory"
      "%popd", "Change to directory popped off the top of the stack"
      "%dirs", "Return a list containing the current directory stack"
      "%dhist", "Print the history of visited directories"
      "%env", "Return the system environment variables as a dict"


.. csv-table:: Python debugger commands
      :header: "Command", "Action"
      :widths: 100, 350

      "h(elp)", "Display command list"
      "help command", "Show documentation for command"
      "c(ontinue)", "Resume program execution"
      "q(uit)", "Exit debugger without executing any more code"
      "b(reak) number", "Set breakpoint at number in current file"
      "b path/to/file.py:number", "Set breakpoint at line number in specified file"
      "s(tep)", "Step into function call"
      "n(ext)", "Execute current line and advance to next line at current level"
      "u(p) / d(own)", "Move up/down in function call stack"
      "a(rgs)", "Show arguments for current function"
      "debug statement", "Invoke statement statement in new (recursive) debugger"
      "l(ist) statement", "Show current position and context at current level of stack"
      "w(here)", "Print full stack trace with context at current position"
