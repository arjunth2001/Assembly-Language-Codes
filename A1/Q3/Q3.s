.global _start

.text

_start:

mov $2, %r8               # Register r8 is my a.
mov $10, %r9               # Register r9 is my b
mov $3,%r10              # Register r10 is my n
mov $1, %r11              # register r11 is my acc
while1:                   # Begin of the first while loop
cmp %r8, %r10             # Comparing n and a 
jg endwhile1              # If n is greater than a  move out of the loop 
sub %r10, %r8             # Doing a = a-n;
jmp while1                # end of the first while loop, jumps up to rerun the loop
endwhile1:                
while2:                   # The beginning of the second while loop
cmp $0, %r9               # Comparing b with 0
jle endwhile2             # If b is less than or equal to 0, exit the loop
mov $1 ,%r12              # Storing 1 in my dummy variable r12
and %r9, %r12             # Logical and of 1 and r12 where r12 is b So, equivalent to b&1
cmp $0, %r12              # Comparing the result of b&1 stored in r12 with 0. 
je in                     # If equal to zero jump to the in statements or end of while loop3
imul %r8, %r11            # acc = acc*a
while3:                   # Taking mode following the old same logic
cmp %r11, %r10
jg endwhile3
sub %r10, %r11
jmp while3
endwhile3:
in:
shr $1, %r9               #  b=b\2
imul %r8, %r8             #  a=a*a
while4:                   # Following the same old logic to find  a*a mod n
cmp %r8, %r10             
jg endwhile4
sub %r10, %r8
jmp while4
endwhile4:
jmp while2
endwhile2:
mov     %r11, %r11
mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall
