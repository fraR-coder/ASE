    .data


v1:  .byte  2, 6, -3, 11,9,7,1,10,1,7,9,11, -3, 6, 2
flag: .space 1

    .text

MAIN:
    dadd R3, R0, R0  #pointer ->
    daddi R2, R0, 14   #pointer <-
    daddi R4, R4, 7     #contatore 
    daddi R1,R0,1      #flag

loop:
    lb R5, v1(R3)
    lb R6, v1(R2)
    bne R5,R6, noPalindromi
    daddi R3,R3,1
    daddi R2,R2,-1
    daddi R4,R4,-1
    bnez R4, loop
    j end

noPalindromi:
    dadd R1,R0,R0

end:
    sb R1,flag(R0)
    halt

