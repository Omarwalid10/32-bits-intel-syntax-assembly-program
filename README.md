# 32-bits-intel-syntax-assembly-program
The program should take n as input and output (1 + 1/1) + (2 + 1/4) + (3 + 1/9) + (4 + 1/16) + ... + (n + 1/(n^2))
##
## How to Run
#### write in cmd in the directore of the file : gcc -O3 -o circuit.exe circuit.s
#### then go to cmd write : circuit.exe
#### enter n integer and press Enter
##
## The Instructions
* Write a 32-bits intel-syntax assembly program that can be compiled in the same way the 32-bits lab samples are compiled.
The program should take the following inputs from the user:
* An integer n.
* n floating point numbers (Use the "double" type. Do not use "float" type.)
The program should output (1 + 1/1) + (2 + 1/4) + (3 + 1/9) + (4 + 1/16) + ... + (n + 1/(n^2)).
Example:
The user inputs: 3
The program outputs: sum=7.361
