FNCSET	.equ	$38
DSPCTRL	.equ	$0f

DATAREG .equ 	$1
CMDREG	.equ	$0
MS_DELAY .equ	$03E8
;MS_DELAY equ	$0001


start:

	LD SP,$80E0

	LD A,FNCSET
	call set

	LD A,DSPCTRL
	call set

	
	LD A,$06			; Entry Mode Set
	call set

	LD A,$01			; CLEAR DISPLAY
	call set

	; Center text
	LD A, $84			; 0x80 = Set DD Ram Address + 0x40 for address on second line
	call set


	LD HL,Name
	call print

	; Go to new line
	LD A, $C0			; 0x80 = Set DD Ram Address + 0x40 for address on second line
	call set

	; Go to new line
	LD A, $C0			; 0x80 = Set DD Ram Address + 0x40 for address on second line
	call set

	LD HL,Hello
	call print

END:	halt


set:
	
	OUT (CMDREG),A
	call DELAY
	ret

print:	LD A, (HL)
	CP 0
	jr z, fin
	OUT (DATAREG),A
	call DELAY
	inc HL
	jr print

fin: ret






DELAY:
	push BC
	LD BC,MS_DELAY
DelayLoop: DEC BC       ; Decrement BC (6 cycles)
	LD A, B      ; Load B into A (4 cycles)
	OR C         ; OR with C (4 cycles) (Set Zero flag if BC = 0)
	JP NZ, DelayLoop  ; Jump to DelayLoop if BC is not zero (10 cycles if taken)
	POP BC
	
	ret




Hello	.db "Hello World!",0

Name	.db "Naz80-a",0


	.END



