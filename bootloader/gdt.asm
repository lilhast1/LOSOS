; Zero Segment
gdt_start:
	dd 0
	dd 0

; Code Segment
gdt_code:
	dw 0xffff		; seglen
	dw 0x0			; segbase
	db 0x0			; segbase
	db 10011010b 	; flags 8bit
	db 11001111b	; flags 4bit + seglen	
	db 0x0			; segbase

; Data Segment
gdt_data:
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1 			; "size" is always 1 less than actual size
	dd gdt_start						; 32bit address 

CODE_SEG equ  gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start