%define ENDL 0x0a, 0x0d

disk_error_msg: db "ERROR WHILE READING DISK", ENDL, 0h



; Print a string
; Params:
;		bx -> ptr to null terminated string
; Return:
;		NONE
Print:
	pusha
.pcloop:
	mov al, [bx]
	or al, al ; check if al is '\0'
	jz .pcend
	mov ah, 0x0e
	int 0x10
	add bx, 1
	jmp .pcloop
.pcend:
	popa
	ret

; Param: dx
; Effect: Print hex value of dx
PrintHex:
	pusha
	mov cx, 0
hex_loop:
	cmp cx, 4
	je end_hex_loop
	mov ax, dx
	and ax, 0x000f
	add al, 0x30
	cmp al, 0x39
	jle hex_out
	add al, 7
hex_out:
	mov bx, HEXTEMP + 5
	sub bx, cx
	mov [bx], al
	ror dx, 4
	add cx, 1
	jmp hex_loop
end_hex_loop:
	mov bx, HEXTEMP
	call Print
	popa
	ret
HEXTEMP: 
	db "0x0000", ENDL, 0

; load DH sectors to ES:BX from DL
DiskLoad:
	pusha
	push dx
	mov ah, 0x02
	mov al, dh
	xor ch, ch
	xor dh, dh
	mov cl, 2h
	int 0x13
	jc disk_error
	pop dx
	cmp dh, al
	jne disk_error
	popa
	ret

disk_error:
	mov si, disk_error_msg
	call Print
	hlt


