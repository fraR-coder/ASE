    .data
a: .byte 1, -2, 3, 4,5 ,6 ,7 ,8,0,1,1, 2, 3, 4,5 ,6 ,7 ,18,0,1,1, 2, 3, 4,5 ,6 ,7 ,8,0,1,1, 2, 3, 4,5 ,6 ,7 ,8,0,1,1, 2, 3, 4,5 ,6 ,7 ,8,0,1
b: .byte 1, -4, 3, 4,5 ,6 ,7 ,8,1,2,1, 2, 3, 4,5 ,6 ,7 ,8,1,2,1, 2, 3, 4,5 ,6 ,7 ,8,1,2,1, 2, 3, 4,5 ,6 ,7 ,8,1,2,1, 2, 3, 4,5 ,6 ,7 ,8,1,2
c: .space 50

max: .space 1
min: .space 1


    .text
Main:
   
   
   dadd R4, R0, R0		#counter
      
   daddi R5, R0, 51 #final dimension

loop:
   
    lb R1, a(R4)
    lb R2, b(R4)
    dadd R3, R2, R1
    sb R3, c(R4)
    daddi R4,R4, 1
    bne R4, R5, loop


    dadd R4, R0, R0		#counter

    dadd R1, R0, R0 #tmp	

    lb R6, c(R4)      #for max
    lb R7, c(R4)      #for min
    daddi R4,R4, 1

search:  
    beq R4, R5, fine
    lb R1, c(R4)
    daddi R4,R4, 1
    slt R2, R6, R1    # R2=1 se R6<R1   R6 max 
    bnez R2, setMax   #R2 è 0 se R1<R6

    slt R3, R1, R7    # R3=1 se R1<R7   R7 min tmp
    bnez R3, setMin   #R3 è 1 se R1<R7
    j search

setMax:
    dadd R6, R0, R1
    j search

setMin:
    dadd R7, R0, R1
    j search

fine:
    sb R6, max(R0)
    sb R7, min(R0)
    halt


    
