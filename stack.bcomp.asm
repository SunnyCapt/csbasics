ORG     020
SP:     7FF
ACC:    WORD ?
PUSH:   WORD ?
        MOV ACC
        CLA
        ADD SP
        DEC
        MOV SP
        CLA
        ADD ACC
        MOV (SP)
        BR(PUSH)

POP:    WORD ?
        CLA
        ADD (SP)
        MOV ACC
        CLA
        ADD SP
        INC
        MOV SP
        CLA
        ADD ACC
        BR (POP)
