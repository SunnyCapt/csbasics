		ORG 0009
ADDR: 	WORD 06B0 ; address of first two characters

		ORG 2FF
ZERO: 	WORD 0000
BUF-A: 	WORD ?
BUF-C: 	WORD ?
SAVE_A_C: 	WORD ?
		MOV BUF-A
		ROL
		MOV BUF-C
		ROR
		BR SAVE_A_C
LOAD_A_C: 	WORD ?
		CLA
		ADD BUF-C
		ROR
		CLA
		CMA
		AND BUF-A
		BR LOAD_A_C
CONSTF:	WORD FF00 ; const for zeroing low 8 bits
CONST0: WORD 00FF ; const for zeroing high 8 bits
STOP:	HLT
STOPC: 	WORD 000D ; stop character
CHECK: 	WORD ? ; character checking
		JSR SAVE_A_C
		AND CONST0
		SUB STOPC
		BMI STOP
		BEQ STOP
		JSR LOAD_A_C
		BR CHECK
ZERO:	WORD 0000
CSHIFT: WORD FFF8 ; const -8 to shift
TIMES:	WORD ?
SHIFT:	WORD ? ; bit shift
		JSR SAVE_A_C
		CLA
		ADD CSHIFT       
		MOV TIMES 
        JSR LOAD_A_C
ROLL:   ROR
		ISZ TIMES
		BR ROLL
		BR SHIFT

		ORG 03DD
BEGIN: 	CLA
START:	BEQ SELECT ; if A == 0 => select new two characters
		BR  SEND ; else send low 8 bits
SELECT:	ADD (ADDR)
		JSR SHIFT
SEND:   JSR CHECK
SPIN	TSF 3
		BR SPIN
		OUT 3
		AND CONSTF ; zeroing low 8 bits in A
		BEQ SELECT
		JSR SHIFT
		ROR	; additional shift due to bit C
		BR SEND