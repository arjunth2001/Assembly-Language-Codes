/* Following is the C code for the following question:
int gcd( int a , int b)
{
	if(b==0)
		return a;
	gcd(b,a%b);
}

int main()
{
	int A,B;
	cin>>A>>B;
	while(gcd(A,B)!=1)
	{
		A=A/gcd(A,B);
	}
	int sum=0;
	while(A!=0)
	{
		sum+= A%10;
                A/=10;
	}
	cout<<sum;
*/
.global _start
.text

gcd:
push %rbp              # push basepointer
mov %rsp, %rbp         # make the current stack pointer the base pointer 
mov 16(%rbp), %r11     # r11 is b the  second argument of gcd function
mov 24(%rbp),%r10      # r10 is a the  first argument of gcd function
cmp $0, %r11           # Compare 0 with b ie r11
mov %r10, %rax         # mov a ie r10 to rax as it might be the return value
je end                 # if b is zero go to end; ie return area
mov $0 , %rdx          # Prepare for div by moving 0 to rdx
div %r11               # Divide with r11 ie, b
push %r11              # push b, ie %r11
push %rdx              # push a%b ie %rdx for next gcd call
call gcd               # call gcd(b,a%b)

end:
mov %rbp,%rsp          # restore stack pointer to previous frame
pop %rbp               # restore previous base pointer
ret                    # return

_start:                # main()
# mov $30, %rbx           # moving value of A to %rbx
# mov $8, %rcx          # moving value of B to %rcx
while:                 # The first while loop that repeatedly removes all common factors of A and B from A.
push %rbx              # push A ie argument 1
push %rcx              # push B ie argument 2
call gcd               # call gcd
cmp $1,%rax            # compare 1 and gcd(A,B)
je endwhile            # if they are equal exit while loop
mov %rax,%rdi          # otherwise store gcd in rdi as a backup
mov $0, %rdx           # mov 0 to rdx to get ready for div
mov %rbx, %rax         # mov A to rax for div
div %rdi               # div A with rdi ie, gcd(A,B)
mov %rax, %rbx         # update A ie rbx with A/gcd(A,B). ie A=A/gcd(A,B)
jmp while              # jump to while, ie do the loop again
endwhile:              # end of first while loop

mov $0, %r8            # r8 is sum variable. Initialising sum as 0
while2:                # The second while loop to calculate sum of digits
cmp $0, %rbx           # compare 0 with A
je endwhile2           # If they are equal end while loop
mov $0,%rdx            # mov 0 to rdx to get ready for div
mov %rbx, %rax         # mov A ie rbx to rax for div
mov $10, %r13          # mov 10 to r13 for div
div %r13               # div A by 10
add %rdx, %r8          # r8 is sum. So adding A%10 to sum
mov %rax, %rbx         # moving A/10 to A. ie A=A/10
jmp while2             # do theb loop again
endwhile2:             # end of second while loop
mov %r8, %rdx          # mov sum to ans variable %rdx as asked in the question

exit:
mov $60 , %rax         # moving 60 to rax for syscall
xor %rdi, %rdi         # xor rdi with rdi for return value 0
syscall                # syscall

