KEY_CONTROL: 	.EQU	$FE
KEY_IN:		.EQU	$FF
BUFFER_LEN:	.EQU 	20



START:
	ld HL,BUFFER
	ld (BUFFER_HEAD),HL


MAIN_LOOP:
	call getKey
	jp Z, MAIN_LOOP
	; Add INPUT to buffer
	ld DE,(BUFFER_HEAD)
	ld (DE),A
	ld HL,BUFFER_HEAD
	INC DE
	ld (BUFFER_HEAD),DE
	jp MAIN_LOOP



; Test if key has been pressed and if it has, get the key and return it in a Register
getKey:
	in A, (KEY_CONTROL)
	bit 0,A
	ret Z			; Return if Control bit is not set
	in A, (KEY_IN)
	ret




org $00A0
BUFFER: ds BUFFER_LEN
BUFFER_HEAD: dw BUFFER