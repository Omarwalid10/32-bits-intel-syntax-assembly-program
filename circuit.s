 
# write in cmd in the directore of the file : gcc -O3 -o circuit.exe circuit.s
# then go to cmd write : circuit.exe
# enter n integer and press Enter

# use the intel syntax, not AT&T syntax. do not prefix registers with %
.intel_syntax noprefix  

# memory variables
.section .data       
# string terminated by 0 that will be used for scanf parameter
input: .asciz "%d"    
# string terminated by 0 that will be used for printf parameter
output: .asciz "Sum = %f\n"  

# the variable n which we will get from user using scanf
n: .int 0         
# the variable sum=(1/i^i)+i that will be calculated
sum: .double 0.0        
one: .double 1.0
i: .double 1.0

# instructions
.section .text 

# make _main accessible from external
.globl _main   

# start
_main:       
# push to stack the second parameter to scanf (the address of the integer variable n)
   push OFFSET n    
   # push to stack the first parameter to scanf
   push OFFSET input 
   # call scanf, it will use the two parameters on the top of the stack in the reverse order
   call _scanf     #    (input,n)

   # pop the above two parameters from the stack 
   add esp, 8        
   # ecx <- n (the number of iterations) to loop n iterations
   mov ecx, n         
loop1:
   #  increase sum by (1/i^i)+i :

   # push 1 to the floating point stack
   fld qword ptr one           
   # pop the floating point stack top (1), divide it over i and push the result (1/i)
   fdiv qword ptr i             
   #to make (1/i)/i=(1/i^i)
   fdiv qword ptr i 
   #to make (1/i^i)+i 
   fadd qword ptr i  
   # pop the floating point stack top (1/i^i)+i , add it to sum, and push the result (sum+(1/i^i)+i )
   fadd qword ptr sum     
   # pop the floating point stack top (sum+(1/i^i)+i ) into the memory variable sum
   fstp qword ptr sum             

   # the following 3 instructions increase i by 1:

   # push 1 to the floating point stack
   fld qword ptr i    
   # pop the floating point stack top (1), add it to i and push the result (i+1)
   fadd qword ptr one  
   # pop the floating point stack top (i+1) into the memory variable i
   fstp qword ptr i 
   
   # when the loop end:
   
   loop loop1         
   # push to stack the high 32-bits of the second parameter to printf (the double at label sum)
   push [sum+4]        
   # push to stack the low 32-bits of the second parameter to printf (the double at label sum)
   push sum   
   # push to stack the first parameter to printf
   push OFFSET output 
   # call printf
   call _printf      
   # pop the two parameters
   add esp, 12    
   # end of the main
   ret               
