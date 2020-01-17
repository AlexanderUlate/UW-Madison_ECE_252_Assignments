; Filename:    hw08.asm
; Author(s):   Alexander Ulate
;              Andy Truong
;
; Description: Performs various operations on values in
;              various memory locations


        .ORIG x0200
START
        LEA R6, data		; get pointer to data array

        ; YOUR CODE GOES BELOW HERE

	; set A equal to data[2]
	LDR R0, R6, #2  ; get data[2] to store to A	
	ST R0, A   	; store data[2] to A
	
	; set B equal to data[1]
	LDR R1, R6, #1	; get data[1] to store to B
	ST R1, B	; store data[1] to B	
	
	; perform opperation C=A-B+20
	NOT R1, R1	; negate value
	ADD R1, R1, #11	; add value 11 to complete negation and add value 10
	ADD R1, R1, #10	; add value 10
	ADD R2, R1, R0	; add B to A
	ST R2, C	; store result to C
	
	; set data[3] equal to 
	STR R2, R6, #3	; store C to data[3]
	
        ; YOUR CODE GOES ABOVE HERE

        BR START

        ; program data

A       .FILL xABCD
B       .FILL xEF01
C       .FILL x2345

      ; Note: normally we would not comment an array like this,
      ; but we wanted to make it easy to see which element is which
data    .FILL #15	    ; data[0]
        .FILL #10	    ; data[1]
        .FILL #-9	    ; data[2]
        .FILL #17	    ; data[3]
		.FILL #83       ; data[4]
		.FILL #49       ; data[5]
		.FILL #57       ; data[6]
	.END
