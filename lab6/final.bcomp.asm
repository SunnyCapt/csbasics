ORG     000
TOBACK: WORD ?
        BR TSFVU

ORG     006
X:      WORD ?

ORG     0FF
BEGIN:  EI
SPIN:   CLA
        DI
        ADD X
        INC
        JSR CHECKA; if -30<=A<=33 then NOP else MIN -> A
        MOV X
        EI
        BR SPIN
;=========================================================
MIN:    WORD FFE2; -30
MAX:    WORD 0021; 33
CHECKA: WORD ? ; checking changed x value in A
        SUB MAX ;
        CMA ;
        INC ;
        BMI SETMIN ; if A > MAX then GOTO SETMIN
        CMA
        INC
        ADD MAX
        SUB MIN
        BMI SETMIN ; if A < MIN then GOTO SETMIN
        ADD MIN
        BR (CHECKA)
SETMIN: CLA
        ADD MIN
        BR (CHECKA)
;=========================================================
TSFVU:  JSR SAVEAC
TSFVU1: TSF 1
        BR TSFVU2
        JSR VU1
TSFVU2: TSF 2
        BR END
        JSR VU2
END:    BR CLFALL
;=========================================================
BUF_A:  WORD ?
BUF_C: 	WORD ?
SAVEAC: WORD ?
        HLT ; check A, C and X
		MOV BUF_A
		ROL
		MOV BUF_C
		ROR
		BR (SAVEAC)
LOADAC:	CLA
		ADD BUF_C
		ROR
		CLA
		CMA
		AND BUF_A
		HLT ; check A, C and X
		EI
        BR (TOBACK)
;=========================================================
CLFALL: WORD ?
        CLF 0
	    CLF 3
        CLF 4
        CLF 5
        CLF 6
        CLF 7
        CLF 8
        CLF 9
        BR LOADAC
;=========================================================
FOUR:	WORD 0004
VU1:    WORD ?
        CLA
        CLC
        SUB X
        CLC
	    ROL
	    CLC
	    ROL
	    CLC
	    ADD FOUR ; -4x + 4 -> A -> VU1
        OUT 1
        CLF 1
        BR (VU1)
;=========================================================
VU2:	WORD ?
        CLA
        IN 2
        HLT ; check X and CHECKA's work
	    SUB X
	    JSR CHECKA
	    MOV X
	    CLF 2
        BR (VU2)