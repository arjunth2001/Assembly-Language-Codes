/*The Question asks the Assembly code for the following Pseudo Code:
  i=1;
  f=1;
  while(i<x)
{
   f=f*i;
   k=f;
   while(k>x)
  {
     k=k-x;
  }
  if(k==0)
      exit;
      
      i++;
}

ans= i;

*/


.global _start

.text

_start:            # Start of the Program

mov $6, %r8       # Moving number to r8 
mov $1, %rax       # rax is my i. I am setting variable i as 1.
mov $1, %r9        # r9 is my f which stores factorial of each i. I am setting variable f  as 1.
while1begins:      # The first loop from C Code
cmp %rax, %r8      # comparing i with x
je exit            # jump to exit if equal to 0 continue the loop if i<x
imul %rax, %r9      # Updating factorial by f=f*i
mov %r9, %r10      # mov f to another variable k
while2begins:      # The Second while of C Code Begins
cmp %r10, %r8     # comparing k with x.
jg while2ends      # If x is greater than k the loop to find remainder ends and hence we jump to the end of the second while
sub %r8, %r10     # Otherwise we continue the loop and subtract x from k and store it in k
jmp while2begins   # We continue to the start of loop 2 to continue for the search for remainder
while2ends:        # At this point the second while loop ends
cmp $0, %r10       # Comparing our remainder k with 0
je exit            # If k==0 that is remainder is zero we exit the first loop and move on to exit
inc %rax            # Otherwise we increment i
jmp while1begins   # And continue loop 1
exit:              # This is the exit part of the code
mov %rax, %r11      # Moving my answer in rax that is i in %r11 as mentioned in the question
mov $60, %rax      # system call 60 is exit
xor %rdi, %rdi     # we want return code 0
syscall



