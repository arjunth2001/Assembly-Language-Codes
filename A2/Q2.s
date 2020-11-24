/*
The following is the C code for the given question

int k;


int fib( int x)
{
	if(x==1)
		return 1;
	if(x==2)
		return 2;
	return fib(x-1)+fib(x-2);

}

int fac(int x)
{
	if(x==1)
		return 1;
	return(( x%k)*(fac(x-1)%k));

}

signed  main()
{       
	int n;
	cin>>n>>k;
	int i=1;
	int sum=0;
	while(fib(i)<=n)
	{
		sum = (sum + fac(fib(i))%k)%k;
		i++;
	}
	cout<<sum<<endl;
	return 0;
}
*/

.global _start
.text

fib:			# The fibonacci function
push %rbp               # Push the base pointer
mov %rsp, %rbp          # Make the current stack pointer the base pointer
mov 16(%rbp), %r11      # Move the argument x to r11. 
cmp $1, %r11            # compare 1 and x
je fibend1              # If they are equal jump to fibend1. It is one of the basecases
cmp $2, %r11            # compare 2 and x
je fibend2              # If they are equal jump to fibend2
dec %r11                # Decrement x
push %r11               # push x-1
call fib                # call fib(x-1)
pop %r11                # restore r11
mov %rax, %r12          # mov return value of fib(x-1) to r12
dec %r11                # decremect r11
push %r12               # push value of fib(x-1).ie caller savee
push %r11               # push r11 ie x-2
call fib                # call fib(x-2)
pop %r11                # restore r11, ie x-2
pop %r12                # restore r12, ie fib(x-1)
add %r12, %rax          # add fib(x-1) to return value of fib(x-2) which is new return
mov %rbp, %rsp          # make base pointer stack pointer
pop %rbp                # restore basepointer
ret                     # return

fibend1:                # One of the base cases
mov $1, %rax            # set return as 1
mov %rbp, %rsp          # make base pointer stack pointer
pop %rbp                # restore base pointer
ret                     # return

fibend2:                # Another one of the base cases
mov $2, %rax            # Move 2 to return value %rax
mov %rbp, %rsp          # make base pointer stack pointer
pop %rbp                # restore basepointer
ret                     # return

fac:                    # The fac function
push %rbp               # Push the current base pointer
mov %rsp, %rbp          # Make stack pointer the base pointer
mov 16(%rsp), %r11      # Take the argument in r11
cmp $1, %r11            # compare 1 with x. (Base Case)
je endfac1              # if they are equal jump to endfac1
mov %r11, %r12          # mov x to r12
dec %r12                # dec r12 to get x-1
push %r11               # push x
push %r12               # push x-1
call fac                # call fac(X-1)
pop %r12                # Restore r12 ie x-1	
pop %r11                # Restore r11 ie x
mov $0, %rdx            # Prepare for div
div %rcx                # Divide fac(x-1) with k
mov %rdx,%r13           # Move the modulo to r13
mov $0, %rdx            # Prepare for another div
mov %r11,%rax           # Now we are trying to find x%k
div %rcx                # Div with k
mov %rdx, %rax          # Move x%k to rax
imul %r13, %rax         # multiply fac(x-1)%k with x%k
mov $0, %rdx            # Prepare for another div
div %rcx                # div fac(x-1)%k* x%k with k
mov %rdx, %rax          # mov the modulo to rax
mov %rbp, %rsp          # make the base pointer the stack pointer
pop %rbp                # Restore the basepointer
ret                     # return

endfac1:                # Base case for factorial function
mov $1, %rax            # Set 1 as return value
mov %rbp, %rsp          # Make the base pointer the stack pointer
pop %rbp                # restore base pointer
ret                     # return

_start:                 # the main function
# mov $5, %rbx          # rbx is n
# mov $13, %rcx          # rcx is k
mov $1, %r8             # r8 is i
mov $0, %r9             # r9 is sum
while:                  # while loop
push %r8                # push i
call fib                # call fib(i)
cmp %rbx, %rax          # Compare n and fib(i)
jg endwhile             # fib(i) is greater than n, then exit loop
push %rax               # push fib(i)
call fac                # call fac(fib(i))
mov %rax, %r10          # move the return value to r10
mov $0, %rdx            # Prepare for div
mov %r10, %rax          # move r10 to rax
div %rcx                # Div with k
add %rdx, %r9           # Add the modulo of fac(fib(i)) with k to sum r9
mov $0, %rdx            # Prepare for div
mov %r9, %rax           # mov sum to rax
div %rcx                # divide sum with k
mov %rdx,%r9            # move sum%k to sum
inc %r8                 # i++
jmp while               # Continue the while loop
endwhile:               # Marks the end of while loop

exit:                   # exit
mov %r9, %rdx           # Store the ans in %rdx
mov $60, %rax           # store 60 is rax for syscall
xor %rdi, %rdi          # xor rdi rdi to get return value 0
syscall                 # syscall
