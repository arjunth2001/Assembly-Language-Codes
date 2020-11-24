/* Pseudo Code for the question from C:
	i=0;
	while(i<n)
	{
		while(!s.empty()&&s.top()>=arr[i])
			s.pop();
		if(s.empty())
			ans[i]=-1;
		else
			ans[i]=s.top();
		s.push(arr[i]);
	}
*/

.global _start
.text



# .align 8                    # Array declaraction for arr[n] for testing
# arr:                         # The array label is arr
# .quad 4                     # Entering the values
# .quad 4
# .quad 5
# .quad 2
# .quad 10
# .quad 8
 

_start:
# mov $6, %rbx                 # Move n to rbx
# lea arr, %rcx                # Move Base Address of input array to rcx
# mov %rsp, %rdx               # Move stack pointer to rdx to get valid address as base address
# mov 8(%rsp,%rbx,8), %rsp     # Allocate space for ans array on stack
mov $0, %r8                  # Using r8 as i. Move 0 to r8
mov %rsp, %r9                # Move the current stack pointer to r9. This defines empty
while1:                      # Beginning of the first while loop
cmp %r8, %rbx                # Compare i with n
jle endwhile1                # If n<=i exit the first while loop
while2:                      # Start the second while loop
cmp %rsp, %r9                # Compare the current stack pointer with r9 to check if empty
je endwhile2                 # If empty, end the second while loop
mov (%rcx, %r8, 8),%r10      # Move arr[i] to r10
pop %r11                     # receive s.top() in r11
push %r11                    # Restore it
cmp %r10, %r11               # Compare s.top() with arr[i]
jl endwhile2                 # if s.top < arr[i], end the second while loop
pop %r11                     # otherwise pop
jmp while2                   # continue the second while loop
endwhile2:                   # marks the end of the second while loop
cmp %rsp, %r9                # Check if the stack is empty
je minus                     # If empty jump to minus label
jne anse                     # If not equal jump to anse label
back:                        # The label to return to after doing the answer part
mov (%rcx,%r8,8),%r10        # mov arr[i] to r10
push %r10                    # push r10
inc %r8                      # increment i, ie i++
jmp while1                   # Continue the first while loop

minus:                       # The minus label, initialises the answer as -1
mov $-1, %r13                # Move -1 to r13
mov %r13, (%rdx, %r8, 8)     # Move r13 to ans[i]
jmp back                     # jump back

anse:                        # The anse label that puts top in ans[i]
pop %r12                     # take value of top in r12
push %r12                    # restore it
mov %r12, (%rdx, %r8, 8)     # move s.top() to arr[i]
jmp back                     # Jump back

endwhile1:                   # End of while loop 1

# mov $0,%r8                   # reinitialise i to 0 to check answers
# while3:                      # while loop that shows ans
# cmp %r8, %rbx                # compare i with n
# je endwhile3                 # If they are equal end while loop
# mov (%rdx, %r8, 8), %r15     # Move ans[i] to r15. Add a break point here to verify. check r15
# inc %r8                      # increment i
# jmp while3                   # continue the while loop
# endwhile3:                   # end of while loop 3

exit:                        # exit label
mov $60, %rax                # move 60 to rax for syscall
xor %rdi,%rdi                # return value 0
syscall                      # syscall



