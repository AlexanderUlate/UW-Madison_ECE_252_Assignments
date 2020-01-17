; Filename:     hw09.asm
; Author:       Alexander Ulate
;               Andy Truong
; Description:  implements the homework 09 flowchart
;               that includes two condition tests

	.ORIG x0200
START
	; YOUR CODE GOES BELOW HERE
	LD R4, L	; get L
	LD R3, K	; get K

	NOT R1, R4	; negate the value of L
	ADD R1, R1, #1	
	
	; check if K is less than L
	ADD R0, R1, R3	; add L to K
	BRn	NEG	; if so, is negative
	; check if K is greater than L
	BRp	POS	; if so, is positive

	; Zero Path
	LD R5, M	; get M
	ST R5, N	; store M to N

	; Negative Path
NEG	ST R4, J	; store L to J
	BR DONE		; 

	; Positive Path
POS	ST R3, M	; store K to M

	; YOUR CODE GOES ABOVE HERE

DONE	BR  START

  ; Program Data

J    .FILL #10
K    .FILL #8
L    .FILL #6
M    .FILL #4
N    .FILL #2

	.END