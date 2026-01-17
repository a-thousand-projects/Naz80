FNCSET	equ	$38
DSPCTRL	equ	$0f

DATAREG equ 	$1
CMDREG	equ	$0
MS_DELAY equ	$03E8
;MS_DELAY equ	$0001


start:

	LD SP,$F0E0

	LD BC,MS_DELAY
	call DELAY


	LD A,FNCSET
	OUT (CMDREG),A

	LD BC,MS_DELAY
	call DELAY

	LD A,DSPCTRL
	OUT (CMDREG),A

	LD BC,MS_DELAY
	call DELAY

	LD A,$06
	OUT (CMDREG),A

	LD BC,MS_DELAY
	call DELAY

	LD A,$01
	OUT (CMDREG),A

	LD BC,MS_DELAY
	call DELAY


	LD bc,str
print:	LD A, (bc)
	CP 0
	jr z, END
	OUT (DATAREG),A
	inc bc
	jr print






DELAY:
	push BC
	LD BC,MS_DELAY
DelayLoop9: DEC BC       ; Decrement BC (6 cycles)
	LD A, B      ; Load B into A (4 cycles)
	OR C         ; OR with C (4 cycles) (Set Zero flag if BC = 0)
	JP NZ, DelayLoop9  ; Jump to DelayLoop if BC is not zero (10 cycles if taken)
	POP BC
	ret

END:	halt


str:	defb "Hello World!"
	defb 0

