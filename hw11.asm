;******************************************************************************
; Filename:    hw11.asm
; Author:      Alexander Ulate - 9078079721, Andy Truong - 9074561961
; Description: Test Code for Median of List subroutines
;******************************************************************************
	.ORIG x0200
START    
	; set initial register values to make it easier to see if
	; they are changed by the subroutine
	LD R0, INITR0
	ADD R1, R0, #1
	ADD R2, R0, #2
	ADD R3, R0, #3
	ADD R4, R0, #4
	ADD R5, R0, #5
	ADD R6, R0, #6
	ADD R7, R0, #7

	; run first test
	LEA R0, Data1
	LD	R1, Length1
	JSR Median

	; run remaining tests
	; figure out what each call should return, and verify that it does

	LEA R0, Data2
	LD 	R1, Length2
	JSR Median

	BR START		; repeat subroutine tests
INITR0 	.FILL 0
Length1 .FILL 5
Data1 	.FILL 33
		.FILL -35
		.FILL 97
		.FILL 11
		.FILL -60
Length2 .FILL 11
Data2	.FILL -73
		.FILL -33
		.FILL -10
		.FILL 31
		.FILL 5
		.FILL -59
		.FILL 28
		.FILL -64
		.FILL -45
		.FILL -46
		.FILL 87

;******************************************************************************
; Subroutine:  Median
; Description: Brute force search for the median of a list of numbers.  Passed
;              the starting address of list in R0, and the length of the list
;              in R1 it searches the numbers in the list till it finds the median.
;              Makes a call to Cnt_GTE for each number searched.  If cnt_GTE 
;              returns a number equal to the length of the list (R1) then the 
;              median is the last number searched and the search terminates and
;			   return the median in R3.
;
; Assumptions:	R1 - length of list is non-zero odd number.
;
; Assumes      R0 - starting address for list
;              R1 - The length of the list (has to be an odd number)
; Returns      R2 - The median of the list
;******************************************************************************
Median
	; YOUR CODE GOES BELOW HERE
	
	ST	R3, Median_R3		; context save
	ST	R1, Median_R1		; context save
	ST 	R7, Median_R7		; context save
	
	ADD R6, R0, #0			; create new counter
	NOT R1, R1				; negate the list to be negative
	ADD R1, R1, #1
	
Median_LOOP
	LDR R2, R6,	#0	; get the search number to compare to list
	ADD R6, R6, #1	; incrament the address for the next search number
	JSR	Cnt_GTE		; check number of values greater than or equal to search number
	ADD R3, R1, R3		;check to see if list equals count
	BRnp Median_LOOP	
	
Median_END
	LD	R3, Median_R3		; context restore
	LD	R1, Median_R1		; context restore
	LD 	R7, Median_R7		; context restore
	RET
; subroutine data
Median_R3	.BLKW	1
Median_R1	.BLKW	1
Median_R7	.BLKW	1


	; YOUR CODE GOES ABOVE HERE


;******************************************************************************
; Subroutine:  Cnt_GTE
; Description: Used to help calculate median of a list.  A "search" number is
;              passed in via R2.  The starting address of a list is passed via R0
;              and the length of the list is passed via R1.  The list is read one
;              number at a time.  If the number is greater than the "search" (R2)
;              number the count is incremented by 2.  If the number is equal to
;              the search number the count is incremented by 1. 
; 
; Assumes      R0 - starting address for list
;              R1 - length of the list
;              R2 - search number
; Returns      R3 - Count
;******************************************************************************
Cnt_GTE
	; YOUR CODE GOES BELOW HERE
	ST	R0, Cnt_GTE_R0		; context save
	ST	R1, Cnt_GTE_R1		; context save
	ST	R4, Cnt_GTE_R4		; context save
	
	
	AND R3, R3, #0	; clear the count
	ADD R1, R1, #-1
	
Cnt_GTE_LOOP	
	LDR R4, R0, #0	; get the target number to compare
	ADD	R0,	R0,	#1		; move to next address for search number
	ADD R1, R1, #1		; increase the loop counter
	
	BRz Cnt_GTE_END	; check if loop is done
	
	NOT	R4, R4		; negate target number
	ADD	R4, R4, #1	

	ADD R4, R4, R2	; check if target number is less than search number
	BRn	Cnt_GTE_LOOP		; if less than, choose next target number
	BRp	Cnt_GTE_GREATER	

Cnt_GTE_EQUAL
	ADD R3, R3, #1	; if equal, increase count by one
	BR	Cnt_GTE_LOOP
	
Cnt_GTE_GREATER
	ADD R3, R3, #2		; if greater, increase count by two
	BR	Cnt_GTE_LOOP


Cnt_GTE_END	


	LD	R0, Cnt_GTE_R0		; context restore
	LD	R1, Cnt_GTE_R1		; context restore
	LD	R4, Cnt_GTE_R4		; context restore	

	RET
; subroutine data	
Cnt_GTE_R0	.BLKW	1
Cnt_GTE_R1	.BLKW	1
Cnt_GTE_R4	.BLKW	1


	; YOUR CODE GOES ABOVE HERE

	.END

