;******************************************
; Bootloader.asm
; A Simple Bootloader
;******************************************
[org 0x7c00]
[bits 16]

start: 
	jmp boot


; Include directives
%include "io.asm"
%include "gdt.asm"
%include "switch.asm"
%include "print32.asm"

[bits 16]
;; constant and variable definitions
HELLO:	
	db	"Vozdra raja!", ENDL, 0h
ALIVE:
	db	"AJMO KURVE!", ENDL, 0h
BOOT_DRIVE: 
	db 0


boot:
	mov bp, 0x8000 ; Stack initialize
	mov sp, bp

	mov bx, HELLO	; Say hello in 16-bit
	call Print

	mov bx, 0x9000
	mov dh, 2
	mov dl, [BOOT_DRIVE] ; Load the disk
	call DiskLoad

	mov dx, [0x9000]	; check if loaded properly
	call PrintHex

	call switch_32 		; switch to protected mode

[bits 32]
HELLO_WORLD:
	mov ebx, ALIVE
	call print32 		; check if we are in 32bits
	
	jmp $
; We have to be 512 bytes. Clear the rest of the bytes with 0
	times 510 - ($-$$) db 0
	dw 0xAA55				  ; Boot Signiture

times 256 dw 0xdada
times 256 dw 0xfaca