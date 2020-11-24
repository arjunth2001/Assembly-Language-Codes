.global _start
.text



# my answer is in %rax

gcd:
push %rbp
mov %rsp, %rbp
mov 16(%rbp), %r11
mov 24(%rbp), %r10
cmp $0 , %r11
mov %r10, %rax
je end
mov $0, %rdx
div %r11
push  %r11
push %rdx
call gcd


end:
mov %rbp, %rsp
pop %rbp
ret


_start:
mov $20, %r8
mov $15, %r9
push %r8
push %r9
call gcd



 



exit:
mov $60, %rax
xor %rdi, %rdi
syscall
