[bits 32]

section .code

global start
extern main

start:
	cli
	mov esp, stack_space
	call main
	jmp $

section .data
times 8192 db 0
stack_space: