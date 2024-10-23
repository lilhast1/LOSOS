[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_BLACK equ 0x0f

;Print nullterminated string pointed to by ebx

print32:
	pusha 
	mov edx, VIDEO_MEMORY
ploop:
	mov al, [ebx]
	mov ah, WHITE_BLACK
	or al, al
	jz pend
	mov [edx], al	; set VGA
	add edx, 2 		; VGA is 2bytes at a time
	add ebx, 1		; next char
	jmp ploop
pend:
	popa
	ret