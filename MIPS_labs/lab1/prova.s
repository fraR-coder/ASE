.data

c: .byte 1, 2, 3, 4, 5, 6, 7

max: .space 1
min: .space 1

.text
MAIN:
    daddi R5,R0, 8

    
    dadd R1, R0, R0	

    

search:  
    lb R1, c(R4)

    daddi R5,R5, -1
    daddi R4,R4,1
    beqz R5,fine
    slt R2, R6, R1    # R2=1 se R6<R1   R6 max tmp
    bnez R2, setMax   #R2 è 0 se R1<R6
    j search


setMax:
    dadd R6, R0, R1
    j search


fine:
    sb R6, max(R4)
    halt

