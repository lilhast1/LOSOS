[bits 16]
switch_32:
	cli							; block interrupts
	lgdt [gdt_descriptor]		; programm the GDT
	mov eax, cr0			
	or eax, 0x1
	mov cr0, eax				; set last bit of cr0-marks the switch to 32bit
	jmp CODE_SEG:hello32		; force a pipeline flush

[bits 32]
hello32:
	mov ax, DATA_SEG	; set the segments
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000 	; set the stack
	mov esp, ebp

	call HELLO_WORLD 	; return to main